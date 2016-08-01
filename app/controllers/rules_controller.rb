class RulesController < ApplicationController
  before_action :set_rule, only: [:edit, :update, :destroy]
  before_action :policies, except: :destroy
  before_action :authenticate_user!

  def index
    @rules = Rule.all.order(created_at: :asc)
  end

  def new
    @rule = Rule.new
  end

  def edit
  end

  def create
    @rule = Rule.new(rule_params)

    if @rule.save
      redirect_to rules_path, notice: 'Rule was successfully created.'
    else
      redirect_to new_rule_path, alert: "Oh snap! You got #{@rule.errors.count} #{"error".pluralize(@rule.errors.count)} in your attempt to make a rule: #{@rule.errors.full_messages.join(", ")}!"
    end
  end

  def update
    if @rule.update(rule_params)
      redirect_to rules_path, notice: 'Rule was successfully updated.'
    else
      redirect_to edit_rule_path(@rule), alert: "Oh snap! You got #{@rule.errors.count} #{"error".pluralize(@rule.errors.count)} in your attempt to update this rule: #{@rule.errors.full_messages.join(", ")}!"
    end
  end

  def destroy
    @rule.destroy
    redirect_to rules_url, notice: 'Rule was successfully destroyed.'
  end

  private
    def set_rule
      @rule = Rule.find(params[:id])
    end

    def policies
      @policy = ["Specific", "Multiple-Of", "Multiple-Of-After"]
      @jsconditions = "if(this.value==='Specific'){ $('#rule_multipleof').hide(); $('#rule_specific').show().attr('placeholder', 'Specific ID?');; } else if(this.value==='Multiple-Of'){ $('#rule_specific').hide(); $('#rule_multipleof').show(); } else if(this.value==='Multiple-Of-After'){ $('#rule_multipleof').show(); $('#rule_specific').show().attr('placeholder', 'After?'); } else{ $('#rule_multipleof').hide(); $('#rule_specific').hide(); }"
    end

    def rule_params
      params.require(:rule).permit(:policy, :specific, :multipleof)
    end
end
