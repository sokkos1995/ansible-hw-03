# Ansible: Vector / ClickHouse / Lighthouse

Playbook поднимает стек через roles:
- **ClickHouse** — `clickhouse` ([AlexeySetevoi/ansible-clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse))
- **Vector** — `vector` ([sokkos1995/vector-role](https://github.com/sokkos1995/vector-role))
- **Lighthouse** — `lighthouse` ([sokkos1995/lighthouse-role](https://github.com/sokkos1995/lighthouse-role))

## Установка ролей (ansible-galaxy)

Из директории `ansible/`:

```bash
# Установить все роли из requirements.yml в ./roles
ansible-galaxy install -r requirements.yml -p roles

# Обновить роли до версий из requirements.yml
ansible-galaxy install -r requirements.yml -p roles --force
```

После установки:

```
roles/
├── clickhouse/
├── vector/
└── lighthouse/
```

## Роли и параметры

### clickhouse (`1.13`)

| Variable | Example | Description |
|----------|---------|-------------|
| `clickhouse_version` | `22.3.3.44` | Версия пакетов |
| `clickhouse_http_port` | `8123` | HTTP порт |
| `clickhouse_tcp_port` | `9000` | Native TCP порт |
| `clickhouse_listen_host` | `["::", "0.0.0.0"]` | Listen addresses |
| `clickhouse_dbs_custom` | `[{ name: logs }]` | Создание БД |

### vector (`main` → лучше зафиксировать тегом `1.0.0`)

| Variable | Default | Description |
|----------|---------|-------------|
| `vector_version` | `0.21.2` | Версия Vector |
| `vector_url` | URL `.deb` | Ссылка на пакет |
| `vector_deb_path` | `./vector.deb` | Куда скачать `.deb` |
| `vector_config_path` | `vector.yml` | Путь к конфигу |
| `vector_config` | sources/sinks | Конфиг Vector (dict) |

Подробнее: https://github.com/sokkos1995/vector-role

### lighthouse (`main` → лучше зафиксировать тегом `1.0.0`)

| Variable | Default | Description |
|----------|---------|-------------|
| `lighthouse_vcs` | `https://github.com/VKCOM/lighthouse.git` | Git-репозиторий |
| `lighthouse_version` | `master` | Ветка / тег |
| `lighthouse_location_dir` | `/var/www/lighthouse` | Каталог установки |
| `lighthouse_access_log_name` | `lighthouse_access` | Имя access-лога |
| `nginx_user_name` | `www-data` | Пользователь nginx |
| `nginx_disable_default_site` | `true` | Удалить default site |

Подробнее: https://github.com/sokkos1995/lighthouse-role

## Структура

```
ansible/
├── group_vars/
│   ├── clickhouse.yml
│   ├── lighthouse.yml
│   └── vector.yml
├── inventory/
│   └── prod.yml
├── requirements.yml
├── roles/              # ansible-galaxy install -p roles
├── ansible.cfg
└── site.yml
```

## Перед запуском

1. В `inventory/prod.yml` — актуальные IP.
2. Хосты Ubuntu, SSH под `ubuntu`.
3. Установите роли: `ansible-galaxy install -r requirements.yml -p roles`.

## Команды

```bash
cd ansible
ansible all -m ping
ansible-playbook site.yml --check
ansible-playbook site.yml --diff
ansible-playbook site.yml
```

## Проверка после деплоя

- Lighthouse: `http://<lighthouse-ip>/`
- ClickHouse: `clickhouse-client -q 'SHOW DATABASES'`
- Vector: конфиг `~/vector.yml`
