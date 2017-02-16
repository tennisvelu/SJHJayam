class Company < ActiveRecord::Base
  belongs_to :address, :dependent => :destroy
  belongs_to :contact, :dependent => :destroy 
  has_many :warehouses, :dependent => :destroy
  has_many :grades, :dependent => :destroy
  has_many :packings, :dependent => :destroy
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact

  def self.damage_bags(params)
    damage=[]
    Warehouse.ids.map do |j|
    company=Warehouse.find(j).company_id
    @warehouse_name=Warehouse.find(j).warehouse_name 
   unless params[:to].present?
      @rail_damage=Damage.where(:warehouse_id=>j).where(:status=>1).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:bags_count).compact.sum
      @road_damage=Damage.where(:warehouse_id=>j).where(:status=>2).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:bags_count).compact.sum
      @return_damage=Damage.where(:warehouse_id=>j).where(:status=>3).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:bags_count).compact.sum
      @warehouse_damage=Damage.where(:warehouse_id=>j).where(:status=>4).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:bags_count).compact.sum
      damage = [company,@warehouse_name,@rail_damage,@road_damage,@warehouse_damage]
   else
      @rail_damage=Damage.where(:warehouse_id=>j).where(:status=>1).where(:created_at=>params[:from]..params[:to]).pluck(:bags_count).compact.sum
      @road_damage=Damage.where(:warehouse_id=>j).where(:status=>2).where(:created_at=>params[:from]..params[:to]).pluck(:bags_count).compact.sum
      @return_damage=Damage.where(:warehouse_id=>j).where(:status=>3).where(:created_at=>params[:from]..params[:to]).pluck(:bags_count).compact.sum
      @warehouse_damage=Damage.where(:warehouse_id=>j).where(:status=>4).where(:created_at=>params[:from]..params[:to]).pluck(:bags_count).compact.sum
     damage = [company,@warehouse_name,@rail_damage,@road_damage,@warehouse_damage]
  	end
    end
  end	

  def self.location_approve(params)
    unless params[:location_ids].nil?
   if params["commit"]=="approve"
    params[:location_ids].map {|i| Location.find(i).update(:status=>1)}
    else
    params[:location_ids].map {|i| Location.find(i).update(:status=>2)}
   end
   end
   end	

   def self.suspense_advance_approve(params)
    unless params[:outward_ids].nil?
   	if params["commit"]=="approve"
     params[:outward_ids].map {|i| OutwardApproval.find(i).update(:status=>1)}
   else
     params[:outward_ids].map {|i| OutwardApproval.find(i).update(:status=>2)}
   end
  end
  end

def self.warehouse_stock(params)
warehouse_stock=[]
Warehouse.ids.map do |l|
company=Warehouse.find(l).company_id
warehouse_name=Warehouse.find(l).warehouse_name
book=Stock.where(:warehouse_id=>l).pluck(:book_stock).compact.sum
physical=Stock.where(:warehouse_id=>l).pluck(:physical_stock).compact.sum
damage=Damage.where(:warehouse_id=>l).pluck(:total_quantity).compact.sum
warehouse_stock = [company,warehouse_name,book,physical,damage]
end
end

def self.direct_sale(params)
@direct=[]
rail_head=LoadingType.find_by(:type_of_loading=>"Rail Head").id
direct_sale=LoadingType.find_by(:type_of_loading=>"Direct Sale").id
transhipment=LoadingType.find_by(:type_of_loading=>"Transhipment").id
godown=LoadingType.find_by(:type_of_loading=>"Godown").id
damage=LoadingType.find_by(:type_of_loading=>"Damage").id
Warehouse.ids.map do |x|
company=Warehouse.find(x).company_id
warehouse_name=Warehouse.find(x).warehouse_name
unless params[:to3].present?
@rail_head  = Outward.where(:warehouse_id=>x).where(:type_of_load=>rail_head).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
@direct_sale = Outward.where(:warehouse_id=>x).where(:type_of_load=>direct_sale).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
@transhipment = Outward.where(:warehouse_id=>x).where(:type_of_load=>transhipment).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
@godown = Outward.where(:warehouse_id=>x).where(:type_of_load=>godown).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
@damage = Outward.where(:warehouse_id=>x).where(:type_of_load=>damage).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
@total = @direct_sale+@rail_head+@transhipment+@godown+@damage
else
    
@rail_head = Outward.where(:warehouse_id=>x).where(:type_of_load=>rail_head).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
@direct_sale = Outward.where(:warehouse_id=>x).where(:type_of_load=>direct_sale).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
@transhipment = Outward.where(:warehouse_id=>x).where(:type_of_load=>transhipment).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
@godown = Outward.where(:warehouse_id=>x).where(:type_of_load=>godown).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
@damage = Outward.where(:warehouse_id=>x).where(:type_of_load=>damage).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
@total = @direct_sale+@rail_head+@transhipment+@godown+@damage
end
@direct =[company,warehouse_name,@rail_head,@direct_sale,@transhipment,@godown,@damage,@total]
end
end


def self.inward_consolidate(params)
Warehouse.ids.map do |x|
company=Warehouse.find(x).company_id
warehouse_name=Warehouse.find(x).warehouse_name
unless params[:to4].present?
  @byroad=Inward.where(:warehouse_id=>x).where(:rail_status=>false).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
  @byrail=Inward.where(:warehouse_id=>x).where(:rail_status=>true).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
  @return=Damage.where(:warehouse_id=>x).where(:status=>3).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:bags_count).compact.sum
else
  
  @byroad=Inward.where(:warehouse_id=>x).where(:rail_status=>false).where(:updated_at=>params[:from]..params[:to4]).pluck(:total_quantity).compact.sum
  @byrail=Inward.where(:warehouse_id=>x).where(:rail_status=>true).where(:updated_at=>params[:from]..params[:to4]).pluck(:total_quantity).compact.sum
  @return=Damage.where(:warehouse_id=>x).where(:updated_at=>params[:from]..params[:to4]).pluck(:bags_count).compact.sum
end
inward=[company,warehouse_name,@byroad,@byrail,@return]
end  
end

end
