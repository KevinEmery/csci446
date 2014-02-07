class AdoptionAgreementsController < ApplicationController
  before_action :set_adoption_agreement, only: [:show, :edit, :update, :destroy]

  # GET /adoption_agreements
  # GET /adoption_agreements.json
  def index
    @adoption_agreements = AdoptionAgreement.all
  end

  # GET /adoption_agreements/1
  # GET /adoption_agreements/1.json
  def show
  end

  # GET /adoption_agreements/new
  def new
    @adoption_agreement = AdoptionAgreement.new
  end

  # GET /adoption_agreements/1/edit
  def edit
  end

  # POST /adoption_agreements
  # POST /adoption_agreements.json
  def create
    @pet = Pet.find(params[:pet_id])
    @adoption_agreement = AdoptionAgreement.new(adoption_agreement_params)

    respond_to do |format|
      if @adoption_agreement.save
        format.html { redirect_to @adoption_agreement, notice: 'Adoption agreement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @adoption_agreement }
      else
        format.html { render action: 'new' }
        format.json { render json: @adoption_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /adoption_agreements/1
  # PATCH/PUT /adoption_agreements/1.json
  def update
    respond_to do |format|
      if @adoption_agreement.update(adoption_agreement_params)
        format.html { redirect_to @adoption_agreement, notice: 'Adoption agreement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @adoption_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adoption_agreements/1
  # DELETE /adoption_agreements/1.json
  def destroy
    @adoption_agreement.destroy
    respond_to do |format|
      format.html { redirect_to adoption_agreements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adoption_agreement
      @adoption_agreement = AdoptionAgreement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def adoption_agreement_params
      params[:adoption_agreement]
    end
end
