class YarnsController < ApplicationController
  before_action :set_yarn, only: %i[ show edit update destroy ]

  # GET /yarns or /yarns.json
  def index
    @yarns = Yarn.all
  end

  # GET /yarns/1 or /yarns/1.json
  def show
  end

  # GET /yarns/new
  def new
    @yarn = Yarn.new
  end

  # GET /yarns/1/edit
  def edit
  end

  # POST /yarns or /yarns.json
  def create
    @yarn = Yarn.new(yarn_params)

    respond_to do |format|
      if @yarn.save
        format.html { redirect_to @yarn, notice: "Yarn was successfully created." }
        format.json { render :show, status: :created, location: @yarn }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @yarn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yarns/1 or /yarns/1.json
  def update
    respond_to do |format|
      if @yarn.update(yarn_params)
        format.html { redirect_to @yarn, notice: "Yarn was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @yarn }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @yarn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yarns/1 or /yarns/1.json
  def destroy
    @yarn.destroy!

    respond_to do |format|
      format.html { redirect_to yarns_path, notice: "Yarn was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yarn
      @yarn = Yarn.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def yarn_params
      params.expect(yarn: [ :title ])
    end
end
