from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

def index(request):
    #return HttpResponse("<center><h3>안녕 장고:)</h3></center>")
    template = loader.get_template('index.html')
    return HttpResponse(template.render())