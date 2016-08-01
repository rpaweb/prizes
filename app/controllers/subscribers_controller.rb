class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :destroy]
  before_action :get_prizes, only: :create

  def index
    @subscribers = Subscriber.all
  end

  def show
  end

  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      ## Verify if this subscriber wins a prize and if many prizes overlap!
      @prizes.each do |prize|
        if @subscriber.id == prize.rule.specific
          @overlap.create(prize_id: prize.id, prize_name: prize.name)
        end if prize.rule.specific && !prize.rule.multipleof
        if @subscriber.id % prize.rule.multipleof == 0
          @overlap.create(prize_id: prize.id, prize_name: prize.name)
        end if prize.rule.multipleof && !prize.rule.specific
        if (@subscriber.id % prize.rule.multipleof == 0) && (@subscriber.id > prize.rule.specific)
          @overlap.create(prize_id: prize.id, prize_name: prize.name)
        end if prize.rule.specific && prize.rule.multipleof
      end

      ## Check for the right prizes and assign to subscribers!
      if @overlap.any?
        prize = @overlap.first
        Winner.create subscriber_id: @subscriber.id, prize_id: prize.prize_id
        Prize.find(prize.prize_id).update amount: Prize.find(prize.prize_id).amount - 1
        prize.destroy
        redirect_to root_path, notice: "Congratulations. You win a prize!!! Prize: #{prize.prize_name}"
      else
        redirect_to root_path, notice: 'Your subscription was successfully created.'
      end
    else
      redirect_to root_path, alert: "Oh snap! You got #{@subscriber.errors.count} #{"error".pluralize(@subscriber.errors.count)} in your attempt to subscribe: #{@subscriber.errors.full_messages.join(", ")}!"
    end
  end

  def destroy
    @subscriber.destroy
    redirect_to subscribers_url, notice: 'Subscriber was successfully destroyed.'
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def get_prizes
      @prizes = Prize.all
      @overlap = TemporalPrize.all
    end

    def subscriber_params
      params.require(:subscriber).permit(:email)
    end
end
