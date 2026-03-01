# devcore

Dockerを活用したローカル開発環境用の共通基盤  
共有インフラとして、リバースプロキシ / データベース / データベース管理ツールを提供  

## 🚀 クイックスタート

### 0. 前提

- Docker / Docker Compose インストール済み
- ポート 80 / 3306 / 9090 が利用可能

### 1. コンテナ起動

```bash
cd /path/to/devcore
docker compose up -d
```
共有ネットワーク(`devcore_shared_network`)はdevcore起動時に自動作成

### 2. アクセス可能になるURL
||||
|-|-|-|
| **ダッシュボード** | [localhost](http://localhost/) | [dashboard.devcore](http://dashboard.devcore) |
| **データベース管理ツール** | [localhost:9090](http://localhost:9090) | [db-manager.devcore](http://db-manager.devcore) |

ドメインでアクセスするには[hosts設定](#hosts設定)が必要

## ✨ 特徴

- 統一されたドメイン体系でアクセス可能
- 全プロジェクトが共有ネットワークで接続
- 全プロジェクトが同一のデータベースを使用可能
- ブラウザからデータベースの管理が可能
- 各プロジェクトは独立したコンテナで動作

## 📋 ディレクトリ構成

```
devcore/
├── docker-compose.yml      # Dockerコンテナ定義
├── docker/                 # コンテナ関連ファイル
│   ├── nginx/
│   │   └── default.conf    # リバースプロキシ設定
│   └── mysql/
│       ├── init/           # 初期化SQL
│       └── my.cnf          # MySQL設定
├── .vscode/                # VSCode設定
│   └── extensions.json     # 推奨拡張機能
├── .editorconfig           # コーディングスタイル設定
└── README.md
```

## 🛠️ 使用方法

### hosts設定
**Win**: `C:\Windows\System32\drivers\etc\hosts`  
**Mac**: `/etc/hosts`

プロジェクトのメイン(通常はwebサーバー)のコンテナ名をドメインに設定  
プロジェクトテンプレート使用時は環境変数(.env)の設定値
```bash
127.0.0.1 ${CONTAINER_NAME}.devcore

# devcore起動時点で追加しておくといいもの
127.0.0.1 dashboard.devcore
127.0.0.1 db-manager.devcore
```

### Dockerコンテナの操作
```bash
# 起動
docker compose up -d

# 停止
docker compose stop

# 再開
docker compose start

# 破棄
docker compose down

# 破棄(ボリューム含む)
docker compose down -v

# ビルド(コンテナのDockerfile編集時等に必要)
docker compose build
```
ボリュームの破棄 = DBの破棄 なので注意

### ログ確認

```bash
# 全サービス
docker compose logs -f

# 特定のサービス
docker compose logs -f ${サービス名}
```

### コンテナ状態確認

```bash
docker compose ps

# Docker全体
docker ps
```

### コンテナ内シェルでコマンドを実行

```bash
docker compose exec ${サービス名} ${コマンド}
```

### ダンプファイル作成
```bash
# docker/mysql/init/dump/ に ${DB_NAME} のダンプファイルを出力するコマンド例
docker compose exec db mysqldump -u root -x ${DB_NAME} > ./docker/mysql/init/dump/${DB_NAME}@`date +%Y%m%d_%H%M%S`.sql
```

### MySQL 初期化スクリプト
[初期化スクリプト](docker/mysql/init/init.sql)を編集することで、コンテナ起動時にDBの初期化が可能  
初期化されるのはdb_volumeが空の時のみ

### 別端末からのアクセス
動作確認時など、別端末からからは**devcoreを起動している端末のIPアドレスとコンテナのポート番号**でアクセス可能

### ネットワーク
ネットワーク(`devcore_shared_network`)は devcore 起動/停止時に自動で作成/削除

## 📝 ライセンス

MIT

### 免責事項

本プロジェクトは Docker Inc. とは一切関係ありません。  
Docker API の公開仕様に基づいて開発されています。

### 使用イメージのライセンス

本プロジェクトは以下のDockerイメージを使用しています。  
各イメージのライセンスに従ってください。

- nginx: [BSD-2-Clause](https://github.com/nginx/nginx/blob/master/docs/text/LICENSE)
- mysql: [GPL-2.0](https://www.mysql.com/about/legal/licensing/oem/)
- phpMyAdmin: [GPL-2.0](https://github.com/phpmyadmin/phpmyadmin/blob/master/LICENSE)
