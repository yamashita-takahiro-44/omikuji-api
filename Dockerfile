# 基本イメージの選択
FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# ワーキングディレクトリの設定
WORKDIR /myapp

# GemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Gemのインストール
RUN bundle install

# プロジェクトのファイルをコンテナにコピー
COPY . /myapp

# 環境変数の設定（本番環境用）
ENV RAILS_ENV=production
ENV RACK_ENV=production

# 本番環境用の依存関係をインストール
RUN bundle install --without development test --deployment

# ポート3000を公開
EXPOSE 3000

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
