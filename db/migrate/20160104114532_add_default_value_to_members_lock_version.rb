class AddDefaultValueToMembersLockVersion < ActiveRecord::Migration
  # railsコマンドでmigrationファイルとひな形を作らせた。 p.284, 285
  # rails g migration add_default_value_to_member_lock_version
  def change
    # migrate実行中に任意のメッセージを出力できるらしい。
    # say 'lock_versionのデフォルト値を0にした。（counter cache機能に対応）'

    # 中身は手作業で記述
    # change_column_default :members, :lock_version, 0

    # デフォルト値のセットは自動Rollbackできないので、手動でupとdownを分けて記述
    reversible do |dir|
      dir.up do
        say 'lock_versionのデフォルト値を0にした。（counter cache機能に対応）'
        change_column_default :members, :lock_version, 0
      end
      dir.down do
        say 'lock_versionのデフォルト値をnilに戻した。'
        change_column_default :members, :lock_version, nil
      end
    end

    # DBへの適用は rake db:migrate
    # ※自動的に schema.rb ファイルにも反映される。
  end

  # migrateおよび巻き戻しを別々のメソッドに分けることもできる。migration全体を分ける場合にはこれの方がわかりやすいか p.293
=begin
  def up
    say 'lock_versionのデフォルト値を0にした。（counter cache機能に対応）'
    change_column_default :members, :lock_version, 0
  end

  def down
    say 'lock_versionのデフォルト値をnilに戻した。'
    change_column_default :members, :lock_version, nil
  end
=end




end
