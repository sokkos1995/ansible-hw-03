# Ansible: Vector / ClickHouse / Lighthouse

Playbook поднимает стек:
- **ClickHouse** — БД `logs`
- **Vector** — сбор логов и отправка в ClickHouse
- **Nginx + Lighthouse** — веб-UI для ClickHouse

## Структура

```
ansible/
├── group_vars/
│   ├── clickhouse.yml
│   ├── lighthouse.yml
│   └── vector.yml
├── inventory/
│   └── prod.yml
├── templates/
│   ├── nginx.conf.j2
│   ├── lighthouse.conf.j2
│   ├── vector.yml.j2
│   └── vector.service.j2
└── site.yml
```

## Перед запуском

1. В `inventory/prod.yml` должны быть актуальные IP (после `terraform apply`).
2. Хосты — Ubuntu, доступны по SSH под пользователем `ubuntu`.
3. Пакеты ставятся через `apt` (deb).

Проверка SSH:

```bash
ssh -i ~/.ssh/id_ed25519 ubuntu@158.160.38.148
ssh -i ~/.ssh/id_ed25519 ubuntu@158.160.49.1
ssh -i ~/.ssh/id_ed25519 ubuntu@158.160.46.41
```

## Команды

Из директории `ansible/`:

```bash
# Проверка доступности хостов
ansible all -i inventory/prod.yml -m ping

# Dry-run (без изменений)
ansible-playbook -i inventory/prod.yml site.yml --check

# Применение с показом diff
ansible-playbook -i inventory/prod.yml site.yml --diff

# Обычный запуск
ansible-playbook -i inventory/prod.yml site.yml

# Повторный запуск (проверка идемпотентности)
ansible-playbook -i inventory/prod.yml site.yml --diff
```

Опционально — lint:

```bash
ansible-lint site.yml
```

## Проверка после деплоя

- Lighthouse: `http://<lighthouse-ip>/`
- ClickHouse: `clickhouse-client -q 'SHOW DATABASES'`
- Vector: `systemctl status vector` (если unit развёрнут) / конфиг `~/vector.yml`
