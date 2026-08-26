from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from django.shortcuts import redirect
from django.utils import timezone

def index(request):
    #return HttpResponse("<center><h3>안녕 장고:)</h3></center>")
    template = loader.get_template('index.html')
    #return HttpResponse(template.render())
    return HttpResponse(template.render({}, request))

from .models import Address
def list(request):
    template = loader.get_template('list.html')
    addresses = Address.objects.all().values()
    context = {'addresses':addresses}
    return HttpResponse(template.render(context, request))

def write(request):
    template = loader.get_template('write.html')
    return HttpResponse(template.render({}, request))

def write_ok(request):
    template = loader.get_template('write.html')
    name = request.POST['name']
    addr = request.POST['addr']
    Address(name=name, addr=addr, rdate=timezone.now()).save()
    return redirect('/joonsapp/list/')