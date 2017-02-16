class CompaniesController < ApplicationController
 before_action :set_company, only: [:show, :edit, :update, :destroy]
include ActionView::Helpers::NumberHelper
  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
   # @company=Company.find(params[:id])
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_contact
    @company.build_address

  end

  # GET /companies/1/edit
  def edit
    #  @company=Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
       Address.find(@company.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
       Address.find(@company.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
     respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def super_admin
    @warehouse=Warehouse.new
    @damage=Company.damage_bags(params)
    @warehouse_stock=Company.warehouse_stock(params)
    @direct_sale=Company.direct_sale(params)
    @inward=Company.inward_consolidate(params)
    @location1=Location.all
    @outward=Outward.new
  end  

  def inward_consolidate
    f=Date.parse(params[:from])    
    from=f.strftime("%Y-%m-%d")

    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>from,:to4=>@to
  end
  
  def id_pass_warehouse
    id=params[:warehouse][:id]
    redirect_to  warehouses_warehouse_admin_path(id)
  end 

  def location_approve
    Company.location_approve(params)     
    redirect_to :back
  end 

  def suspense_advance_approve
    Company.suspense_advance_approve(params)
    redirect_to :back
  end 

  def damage_date
    f=Date.parse(params[:from])    
    from=f.strftime("%Y-%m-%d")
    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>from,:to=>@to
  end 

  def approve_reject_report
    f=Date.parse(params[:from])    
    from=f.strftime("%Y-%m-%d")
    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>from,:to2=>@to
  end  
  
  def direct_sale
    f=Date.parse(params[:from])    
    from=f.strftime("%Y-%m-%d")
   to=Date.parse(params[:to])+1
   @to=to.strftime("%Y-%m-%d")
   redirect_to :action=>"super_admin",:from=>from,:to3=>@to  
  end

  def grade
  @company_grade=Grade.where(:company_id=>params[:format])
  @grade=Grade.new
  end  

  def grade_save
    @grade=Grade.new(grade_params)
   if @grade.save
    @grade.update(:company_id=>params[:format])
   end
    redirect_to :action=>"grade",:format=>params[:format]
  end  

 def grade_update
  Grade.find(params[:id]).update(:grade_type=>params[:grade])
  redirect_to :action=>"grade",:format=>params[:format]
 end 
 
 def grade_delete
  Grade.find(params[:id]).delete
  GradePacking.where(:grade_id=>params[:id]).delete_all 
  Stock.where(:grade_id=>params[:id]).delete_all
  Damage.where(:grade=>params[:id]).delete_all
 if InwardManufactureDetail.where(:grading=>params[:id]).present?
  inward=InwardManufactureDetail.where(:grading=>params[:id]).pluck(:inward_id)
  InwardManufactureDetail.where(:grading=>params[:id]).delete_all
  unless InwardManufactureDetail.where(:inward_id=>inward).present?
  Inward.where(:id=>inward).delete_all
  end
 end
 if OutwardManufactureDetail.where(:grading=>params[:id]).present?
  outward=OutwardManufactureDetail.where(:grading=>params[:id]).pluck(:outward_id)
  OutwardManufactureDetail.where(:grading=>params[:id]).delete_all 
  unless OutwardManufactureDetail.where(:outward_id=>outward_id).present?
  Outward.where(:id=>outward).delete_all
  end
 end
  redirect_to :action=>"grade",:format=>params[:format]
 end 

 def packing
  @company_packing=Packing.where(:company_id=>params[:format])
  @packing=Packing.new
  end  

  def packing_save
    packing=Packing.create(packing_params)
    packing.update(:company_id=>params[:format])
    redirect_to :action=>"packing",:format=>params[:format]
  end  

 def packing_update
  Packing.find(params[:id]).update(:packing_type=>params[:packing])
  redirect_to :action=>"packing",:format=>params[:format]
 end 
 
 def packing_delete
  Packing.find(params[:id]).delete
  GradePacking.where(:packing_id=>params[:id]).delete_all
  Stock.where(:packing_id=>params[:id]).delete_all
  if InwardManufactureDetail.where(:packing=>params[:id]).present?
  inward=InwardManufactureDetail.where(:packing=>params[:id]).pluck(:inward_id)
  InwardManufactureDetail.where(:packing=>params[:id]).delete_all
  unless InwardManufactureDetail.where(:inward_id=>inward).present?
  Inward.where(:id=>inward).delete_all
  end
 end
 if OutwardManufactureDetail.where(:packing=>params[:id]).present?
  outward=OutwardManufactureDetail.where(:packing=>params[:id]).pluck(:outward_id)
  OutwardManufactureDetail.where(:packing=>params[:id]).delete_all 
  unless OutwardManufactureDetail.where(:outward_id=>outward).present?
  Outward.where(:id=>outward).delete_all
  end
 end
  redirect_to :action=>"packing",:format=>params[:format]
 end

 def gradepacking
  @grade_packing=GradePacking.new
  @grade_id=params[:id]
  @company_id=params[:format]
  @grade=GradePacking.where(:grade_id=>@grade_id)
 end 

 def grade_packing_mapping
  GradePacking.create(:grade_id=>params[:grade_id],:packing_id=>params[:grade_packing][:packing_id])
    warehouse_id=Warehouse.where(:company_id=>params[:format]).pluck(:id)
    warehouse_id.map do |i| 
    Stock.create(:grade_id=>params[:grade_id],:packing_id=>params[:grade_packing][:packing_id],:book_stock=>0,:physical_stock=>0,:warehouse_id=>i)
    end
  redirect_to :action=>"gradepacking",:format=>params[:format],:id=>params[:grade_id]
 end 

 def grade_packing_delete

  GradePacking.find(params[:grade_packing_id]).delete
  Stock.where(:grade_id=>params[:grade_id],:packing_id=>params[:packing_id]).delete_all
  redirect_to :action=>"gradepacking",:format=>params[:format],:id=>params[:grade_id]
 end 
  
private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:company_name, :contact_id, :address_id, :isactive, :created_by, :updated_by,contact_attributes: [:email,:telephone_number, :mobile_number], address_attributes: [:address1, :post_code, :city, :state, :country])
    end

    def grade_params
      params.require(:grade).permit!
    end

    def packing_params
      params.require(:packing).permit!
    end

    def grade_packing_params
      params.require(:grade_packing).permit!
    end
end
