from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from django.shortcuts import redirect
from django.utils import timezone
from django.urls import reverse


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

#def write_ok(request):
    template = loader.get_template('write.html')
    name = request.POST['name']
    addr = request.POST['addr']
    Address(name=name, addr=addr, rdate=timezone.now()).save()
    return redirect('/joonsapp/list/')

#def write_ok(request):
    x = request.POST['name']
    y = request.POST['addr']
    nowDatetime = timezone.now().strftime('%Y-%m-%d %H:%M:%S')
    address = Address(name=x, addr=y, rdate=nowDatetime)
    address.save()
    return HttpResponseRedirect(reverse('list'))

def write_ok(request):
    name = request.POST['name']
    addr = request.POST['addr']
    nowDatetime = timezone.now().strftime('%Y-%m-%d %H:%M:%S')
    address = Address(name=name, addr=addr, rdate=nowDatetime)
    address.save()
    return redirect('list')

def delete(request):
    seq = request.GET['seq']
    Address.objects.get(id=seq).delete()
    return redirect('/joonsapp/list/')
