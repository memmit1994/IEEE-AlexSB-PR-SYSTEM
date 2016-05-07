class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /contacts
  # GET /contacts.json
  def index
    
    @isAdmin = is_admin?
    if params[:query]
        if @isAdmin
          @contacts = Contact.search_in_all(params[:query])
        else #if guest

          if params[:by_name]=="on" and not params[:by_field]
            @contacts = Contact.search_by_name(params[:query])
          elsif params[:by_field]=="on" and not params[:by_name] 
            @contacts = Contact.search_by_field_company(params[:query])

          elsif params[:by_field]=="on" and params[:by_name] =="on"
            @contacts = Contact.search_guest_all(params[:query])
          end
        end

    else 
      if @isAdmin 
        @contacts= Contact.page(params[:page]).per_page(9)
      end
    end
  end


  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @isAdmin = is_admin?
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.id = Contact.all.last.id + 1
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.id = Contact.all.last.id + 1
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :number, :position, :field_company, :email,:photo)
    end
    def is_admin?
      if current_user
        current_user.email=="admin@admin.com"
      else 
        false
      end
    end
end
