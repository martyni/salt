common_packages:
  pkg.installed:
    - pkgs:
      - python-pip
      - git

python_packages:
  pip.installed:
    - name: virtualenv
    - require: 
      - pkg: common_packages 

app_user:
  user.present:
    - name: "app"
    - home: "/home/app"
 
code:
  git.latest:
    - name: "https://github.com/martyni/app"
    - target: "/home/app/code"
    - user: "app"
    - require:
       - user: app_user

app_virtualenv:
  virtualenv.managed:
    - name: "/home/app/env"
    - user: "app"
    - require:
       - pip: python_packages

virtual_packages:
  pip.installed:
    - requirements: "/home/app/code/requirements.txt"
    - bin_env: "/home/app/env"
    - user: "app"
    - require:
       - virtualenv: app_virtualenv
     
