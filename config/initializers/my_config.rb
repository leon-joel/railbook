# 現在の Rails.env (developmentなど)をキーに持つconfigだけを取得

# アプリケーション内のどこからでもMY_APPにアクセスできる
MY_APP = 
  YAML.load(
    File.read("#{Rails.root}/config/my_config.yml"))[Rails.env]

# [Rails.env]の前に改行を入れると上手く動かない…
# Rubyの仕様なんだろうけどよく分かってない(^_^;)
