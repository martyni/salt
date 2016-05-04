supervisor:
  service.running:
    - require:
       - sls: app.packages

supervisor-conf:
  file.managed:
    - name: "/etc/supervisor/conf.d/app.conf"
    - source: salt://app/files/supervisor.conf
    - template: jinja
    - require:
       - service: supervisor

supervisor_app:
   supervisord.running:
     - name: "app"
     - update: True
     - require:
        - file: supervisor-conf 
         
      
      
