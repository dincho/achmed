{% for key,value in symfony_env.iteritems() %}
export {{ key }}="{{ value }}"
{% endfor -%}
