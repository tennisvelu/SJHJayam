class Warehouse < ActiveRecord::Base
  has_many :outwards, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :stocks, :dependent => :destroy
  has_many :inwards, :dependent => :destroy
  has_many :users, :dependent => :destroy
  belongs_to :address, :dependent => :destroy
  belongs_to :contact, :dependent => :destroy 
  belongs_to :company
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact

def self.admin_warehouse_id(user_id)
   warehouse_session_id=User.find(user_id).warehouse_id
end

 def self.warehouse_stock(params,warehouse_session_id)
  Stock.where(:warehouse_id=>warehouse_session_id).pluck(:grade_id,:packing_id,:book_stock,:physical_stock)
 end	


 def self.warehouse_direct_sale(params,warehouse_session_id)
 direct=[] 
 rail_head=LoadingType.find_by(:type_of_loading=>"Rail Head").id
 direct_sale=LoadingType.find_by(:type_of_loading=>"Direct Sale").id
 transhipment=LoadingType.find_by(:type_of_loading=>"Transhipment").id
 godown=LoadingType.find_by(:type_of_loading=>"Godown").id
 damage=LoadingType.find_by(:type_of_loading=>"Damage").id

  unless params[:to3].present?
   @rail_head=Outward.where(:type_of_load=>rail_head).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
   @direct_sale=Outward.where(:type_of_load=>direct_sale).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
   @transhipment=Outward.where(:type_of_load=>transhipment).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
   @godown=Outward.where(:type_of_load=>godown).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
   @damage=Outward.where(:type_of_load=>damage).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
   @total=@rail_head+@direct_sale+@transhipment+@godown+@damage
  else
   @rail_head=Outward.where(:type_of_load=>rail_head).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
   @direct_sale=Outward.where(:type_of_load=>direct_sale).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
   @transhipment=Outward.where(:type_of_load=>transhipment).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
   @godown=Outward.where(:type_of_load=>godown).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
   @damage=Outward.where(:type_of_load=>damage).where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
   @total=@rail_head+@direct_sale+@transhipment+@godown+@damage
  end
   direct=[@rail_head,@direct_sale,@transhipment,@godown,@damage,@total]
 end
 
 def self.warehouse_damage(params,warehouse_session_id)
  unless params[:to2].present?
   damage=Damage.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
  else
   damage=Damage.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to2])
  end
 end 	

 def self.warehouse_inward(params,warehouse_session_id)
  unless params[:type].present?
  if params[:to].present?
   inward=Inward.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to])
  else
   inward=Inward.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
  end
  else
  if params[:type]=="ByRoad"
   inward=Inward.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to]).where(:rail_status=>false)  
  else
    inward=Inward.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>params[:from]..params[:to]).where(:rail_status=>true)    
  end
  end
 end	

 def self.damage_entries(params,warehouse_session_id)
   date=params[:damage_entry_date] 
   grade=params[:grade]
   bags_count=params[:bags_count]
      (0..date.count-1).map do |i|
       if Damage.where(:warehouse_id=>warehouse_session_id).empty?
        @damage= Damage.create(:damage_entry_date=>date[i],:grade=>grade[i],:bags_count=>bags_count[i],:warehouse_id=>warehouse_session_id,:status=>4)
        @damage.update(:total_quantity=>@damage.bags_count)
       else
         quantity=Damage.where(:warehouse_id=>warehouse_session_id).last.total_quantity
         @damage= Damage.create(:damage_entry_date=>date[i],:grade=>grade[i],:bags_count=>bags_count[i],:warehouse_id=>warehouse_session_id,:status=>4) 
         total=quantity+@damage.bags_count
         @damage.update(:total_quantity=>total)
       end
      end
 end

 def self.outward_date(params,warehouse_session_id)
  unless params[:to1].present?
    #@current_outward1=Outward.where(:warehouse_id=>warehouse_session_id).where(:payment_type=>[0,1]).where(:status=>[0,3]).where(:updated_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
    #@current_outward2=Outward.where(:warehouse_id=>warehouse_session_id).where(:payment_type=>2).where(:status=>[3,4]).where(:updated_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
    @current_outward1=Outward.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
    #@current_outward2=Outward.where(:warehouse_id=>warehouse_session_id).where(:updated_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
   else
    #@current_outward1=Outward.where(:warehouse_id=>warehouse_session_id).where(:payment_type=>[0,1]).where(:status=>[0,3]).where(:created_at=>params[:from]..params[:to1])
    #@current_outward2=Outward.where(:warehouse_id=>warehouse_session_id).where(:payment_type=>2).where(:status=>[3,4]).where(:created_at=>params[:from]..params[:to1])
    @current_outward1=Outward.where(:warehouse_id=>warehouse_session_id).where(:created_at=>params[:from]..params[:to1])
    #@current_outward2=Outward.where(:warehouse_id=>warehouse_session_id).where(:created_at=>params[:from]..params[:to1])
   
   end
   @current_outward=@current_outward1#+@current_outward2
 end  	


 def self.approve_reject_report(params,warehouse_session_id)  
  if params[:to5].present?
    if params[:range]=="Approve"
    approval_reject_id=OutwardApproval.where(:warehouse_id=>warehouse_session_id).where(:status=>[1,3,4]).where(:created_at=>params[:from]..params[:to5])
   elsif params[:range]=="Reject"
    approval_reject_id=OutwardApproval.where(:warehouse_id=>warehouse_session_id).where(:status=>[2,9]).where(:created_at=>params[:from]..params[:to5])   
   else
    approval_reject_id=OutwardApproval.where(:warehouse_id=>warehouse_session_id).where(:status=>[1,2,3,4,9]).where(:created_at=>params[:from]..params[:to5]) 
   end
  else
    approval_reject_id=OutwardApproval.where(:warehouse_id=>warehouse_session_id).where(:status=>[1,2,3,4,9]).where(:created_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
  end
 end

def self.inward_consolidate(params,warehouse_session_id)
 inward=[]
 unless params[:to4].present?
 @byroad=Inward.where(:rail_status=>false).where(:warehouse_id=>warehouse_session_id).where(:return=>false).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum  
 @byrail=Inward.where(:rail_status=>true).where(:warehouse_id=>warehouse_session_id).where(:return=>false).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:total_quantity).compact.sum
 @byreturn=Damage.where(:warehouse_id=>warehouse_session_id).where(:status=>3).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).pluck(:bags_count).compact.sum
 @bydamage=Damage.where(:warehouse_id=>warehouse_session_id).where(:created_at=>Date.today.strftime("%Y-%m-01")..(Date.today+1).strftime("%Y-%m-%d")).where(:status=>[1,2,3]).pluck(:bags_count).compact.sum
 else
 @byroad=Inward.where(:rail_status=>false).where(:warehouse_id=>warehouse_session_id).where(:return=>false).where(:created_at=>params[:from]..params[:to4]).pluck(:total_quantity).compact.sum  
 @byrail=Inward.where(:rail_status=>true).where(:warehouse_id=>warehouse_session_id).where(:return=>false).where(:created_at=>params[:from]..params[:to4]).pluck(:total_quantity).compact.sum
 @byreturn=Damage.where(:warehouse_id=>warehouse_session_id).where(:status=>3).where(:created_at=>params[:from]..params[:to4]).pluck(:bags_count).compact.sum
 @bydamage=Damage.where(:warehouse_id=>warehouse_session_id).where(:created_at=>params[:from]..params[:to4]).where(:status=>[1,2,3]).pluck(:bags_count).compact.sum
 end 
 inward=[@byroad,@byrail,@byreturn,@bydamage]
 end


 def self.document(params,warehouse_session_id)

 unless params[:to6].present?
   Document.where(:warehouse_id=>warehouse_session_id).where(:created_at=>Date.yesterday.strftime("%Y-%m-%d")..(Date.today+1).strftime("%Y-%m-%d"))
 else
  Document.where(:warehouse_id=>warehouse_session_id).where(:created_at=>params[:from]..params[:to6])
 end

end

end
