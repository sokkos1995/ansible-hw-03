# Домашнее задание к занятию 4 «Работа с roles»

## Подготовка к выполнению

1. * Необязательно. Познакомьтесь с [LightHouse](https://youtu.be/ymlrNlaHzIY?t=929).
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю на GitHub.

## Основная часть

Ваша цель — разбить ваш playbook на отдельные roles. 

Задача — сделать roles для ClickHouse, Vector и LightHouse и написать playbook для использования этих ролей. 

Ожидаемый результат — существуют три ваших репозитория: два с roles и один с playbook.

**Что нужно сделать**

1. Создайте в старой версии playbook файл `requirements.yml` и заполните его содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.13"
       name: clickhouse 
   ```

2. При помощи `ansible-galaxy` скачайте себе эту роль.
3. Создайте новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 
5. Перенести нужные шаблоны конфигов в `templates`.
6. Опишите в `README.md` обе роли и их параметры. Пример качественной документации ansible role [по ссылке](https://github.com/cloudalchemy/ansible-prometheus).
7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.
9. Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения `roles` с `tasks`.
10. Выложите playbook в репозиторий.
11. В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

---

## Решение

```bash
ansible-playbook site.yml

PLAY [Install ClickHouse] ********************************************************

TASK [Gathering Facts] ***********************************************************
ok: [clickhouse-01]

TASK [clickhouse : Include OS Family Specific Variables] *************************
[WARNING]: Deprecation warnings can be disabled by setting `deprecation_warnings=False` in ansible.cfg.
[DEPRECATION WARNING]: INJECT_FACTS_AS_VARS default to `True` is deprecated, top-level facts will not be auto injected after the change. This feature will be removed from ansible-core version 2.24.
Origin: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/main.yml:8:11

6     params:
7       files:
8         - "{{ ansible_os_family | lower }}.yml"
            ^ column 11

Use `ansible_facts["fact_name"]` (no `ansible_` prefix) instead.

ok: [clickhouse-01]

TASK [clickhouse : include_tasks] ************************************************
included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/precheck.yml for clickhouse-01

TASK [clickhouse : Requirements check | Checking sse4_2 support] *****************
ok: [clickhouse-01]

TASK [clickhouse : Requirements check | Not supported distribution && release] ***
skipping: [clickhouse-01]

TASK [clickhouse : include_tasks] ************************************************
included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/params.yml for clickhouse-01

TASK [clickhouse : Set clickhouse_service_enable] ********************************
ok: [clickhouse-01]

TASK [clickhouse : Set clickhouse_service_ensure] ********************************
ok: [clickhouse-01]

TASK [clickhouse : include_tasks] ************************************************
[DEPRECATION WARNING]: apt_key has been deprecated. Use deb822_repository instead. This feature will be removed from ansible-core version 2.25.
Origin: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/install/apt.yml:6:3

4
5 - name: Install by APT | Apt-key add repo key
6   apt_key:
    ^ column 3

[DEPRECATION WARNING]: apt_repository has been deprecated. Use deb822_repository instead. This feature will be removed from ansible-core version 2.25.
Origin: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/install/apt.yml:13:3

11
12 - name: Install by APT | Remove old repo
13   apt_repository:
     ^ column 3

[DEPRECATION WARNING]: apt_repository has been deprecated. Use deb822_repository instead. This feature will be removed from ansible-core version 2.25.
Origin: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/install/apt.yml:21:3

19
20 - name: Install by APT | Repo installation
21   apt_repository:
     ^ column 3

included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/install/apt.yml for clickhouse-01

TASK [clickhouse : Install by APT | Apt-key add repo key] ************************
ok: [clickhouse-01]

TASK [clickhouse : Install by APT | Remove old repo] *****************************
[DEPRECATION WARNING]: INJECT_FACTS_AS_VARS default to `True` is deprecated, top-level facts will not be auto injected after the change. This feature will be removed from ansible-core version 2.24.
Origin: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/vars/debian.yml:4:22

2 clickhouse_supported: true
3 clickhouse_repo: "deb https://packages.clickhouse.com/deb stable main"
4 clickhouse_repo_old: >-
                       ^ column 22

Use `ansible_facts["fact_name"]` (no `ansible_` prefix) instead.

ok: [clickhouse-01]

TASK [clickhouse : Install by APT | Repo installation] ***************************
ok: [clickhouse-01]

TASK [clickhouse : Install by APT | Package installation] ************************
ok: [clickhouse-01]

TASK [clickhouse : Install by APT | Package installation] ************************
skipping: [clickhouse-01]

TASK [clickhouse : Hold specified version during APT upgrade | Package installation] ***
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [clickhouse : include_tasks] ************************************************
included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/configure/sys.yml for clickhouse-01

TASK [clickhouse : Check clickhouse config, data and logs] ***********************
ok: [clickhouse-01] => (item=/var/log/clickhouse-server)
ok: [clickhouse-01] => (item=/etc/clickhouse-server)
ok: [clickhouse-01] => (item=/var/lib/clickhouse/tmp/)
ok: [clickhouse-01] => (item=/var/lib/clickhouse/)

TASK [clickhouse : Config | Create config.d folder] ******************************
ok: [clickhouse-01]

TASK [clickhouse : Config | Create users.d folder] *******************************
ok: [clickhouse-01]

TASK [clickhouse : Config | Generate system config] ******************************
ok: [clickhouse-01]

TASK [clickhouse : Config | Generate users config] *******************************
ok: [clickhouse-01]

TASK [clickhouse : Config | Generate remote_servers config] **********************
skipping: [clickhouse-01]

TASK [clickhouse : Config | Generate macros config] ******************************
skipping: [clickhouse-01]

TASK [clickhouse : Config | Generate zookeeper servers config] *******************
skipping: [clickhouse-01]

TASK [clickhouse : Config | Fix interserver_http_port and intersever_https_port collision] ***
skipping: [clickhouse-01]

TASK [clickhouse : Notify Handlers Now] ******************************************

TASK [clickhouse : include_tasks] ************************************************
included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/service.yml for clickhouse-01

TASK [clickhouse : Ensure clickhouse-server.service is enabled: True and state: started] ***
ok: [clickhouse-01]

TASK [clickhouse : Wait for Clickhouse Server to Become Ready] *******************
ok: [clickhouse-01]

TASK [clickhouse : include_tasks] ************************************************
included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/configure/db.yml for clickhouse-01

TASK [clickhouse : Set ClickHose Connection String] ******************************
ok: [clickhouse-01]

TASK [clickhouse : Gather list of existing databases] ****************************
ok: [clickhouse-01]

TASK [clickhouse : Config | Delete database config] ******************************
skipping: [clickhouse-01] => (item={'name': 'logs'}) 
skipping: [clickhouse-01]

TASK [clickhouse : Config | Create database config] ******************************
skipping: [clickhouse-01] => (item={'name': 'logs'}) 
skipping: [clickhouse-01]

TASK [clickhouse : include_tasks] ************************************************
included: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/clickhouse/tasks/configure/dict.yml for clickhouse-01

TASK [clickhouse : Config | Generate dictionary config] **************************
skipping: [clickhouse-01]

TASK [clickhouse : include_tasks] ************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ************************************************************

TASK [Gathering Facts] ***********************************************************
ok: [vector-01]

TASK [vector : Vector | Download deb] ********************************************
changed: [vector-01]

TASK [vector : Vector | Install deb] *********************************************
changed: [vector-01]

TASK [vector : Vector | Template config] *****************************************
[DEPRECATION WARNING]: INJECT_FACTS_AS_VARS default to `True` is deprecated, top-level facts will not be auto injected after the change. This feature will be removed from ansible-core version 2.24.
Origin: /Users/konstantinsokolov/dev/projects/pet_projects/devops/03_ansible/hw/hw03/ansible/roles/vector/tasks/main.yml:20:12

18     dest: "{{ vector_config_path }}"
19     mode: "{{ vector_config_mode }}"
20     owner: "{{ ansible_user_id }}"
              ^ column 12

Use `ansible_facts["fact_name"]` (no `ansible_` prefix) instead.

changed: [vector-01]

PLAY [Install Lighthouse] ********************************************************

TASK [Gathering Facts] ***********************************************************
ok: [lighthouse-01]

TASK [lighthouse : NGINX | Install NGINX] ****************************************
changed: [lighthouse-01]

TASK [lighthouse : NGINX | Disable default site] *********************************
changed: [lighthouse-01]

TASK [lighthouse : NGINX | Create general config] ********************************
changed: [lighthouse-01]

TASK [lighthouse : Lighthouse | Install dependencies] ****************************
ok: [lighthouse-01]

TASK [lighthouse : Lighthouse | Copy from git] ***********************************
changed: [lighthouse-01]

TASK [lighthouse : Lighthouse | Create lighthouse config] ************************
changed: [lighthouse-01]

RUNNING HANDLER [lighthouse : start-nginx] ***************************************
ok: [lighthouse-01]

RUNNING HANDLER [lighthouse : restart-nginx] *************************************
changed: [lighthouse-01]

PLAY RECAP ***********************************************************************
clickhouse-01              : ok=26   changed=0    unreachable=0    failed=0    skipped=10   rescued=0    ignored=0   
lighthouse-01              : ok=9    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---