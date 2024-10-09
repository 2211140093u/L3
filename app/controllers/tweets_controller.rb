class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  
  # ツイートをtdate順に並べる
  def index
    @tweets = Tweet.order(tdate: :desc)
  end
  
  # ツイート作成用のフォームを表示する
  def new
    @tweet = Tweet.new
  end
  
  # ツイートを作成
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.tdate = Time.current  # ツイート日時に現在時刻をセット
    
    # バリデーションに成功すれば保存、失敗すればフォームを再表示
    if @tweet.save
      flash[:notice] = "正常にツイートされました。"
      redirect_to tweets_path  # ツイート一覧にリダイレクト
    else
      flash[:alert] = "ツイートの作成に失敗しました。1〜140文字以内で入力してください。"
      render :new  # 新規作成画面を再表示
    end
  end
  
  # 特定のツイートを表示
  def show
  end
  
  # 編集用のフォームを表示
  def edit
  end
  
  # ツイートを編集
  def update
    # バリデーションに成功すれば更新、失敗すればフォームを再表示
    if @tweet.update(tweet_params)
      flash[:notice] = "ツイートが正常に更新されました。"
      redirect_to @tweet  # 更新後、ツイート詳細にリダイレクト
    else
      flash[:alert] = "ツイートの更新に失敗しました。1〜140文字以内で入力してください。"
      render :edit  # 編集画面を再表示
    end
  end
  
  # 特定のツイートを削除する
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to '/'  # ツイート一覧にリダイレクト
  end
  
  private

  # 特定のツイートをセットする
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # メッセージ部分のみを許可
  def tweet_params
    params.require(:tweet).permit(:message)
  end
  
end
