from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
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

#def delete(request):
    seq = request.GET['seq']
    Address.objects.get(id=seq).delete()
    return redirect('/joonsapp/list/')

def delete(request, id):
    address = Address.objects.get(id=id)
    address.delete()
    return HttpResponseRedirect(reverse('list'))

#def update(request, id):
    address = Address.objects.get(id=id)

    if request.method == 'POST':
        address.name = request.POST['name']
        address.addr = request.POST['addr']
        address.save()
        return redirect('list')
    else:
        return render(request, 'update.html', {'address':address})

def update(request, id):
    template = loader.get_template('update.html')
    address = Address.objects.get(id=id)
    context = { 'address':address, }
    return HttpResponse(template.render(context, request))

def update_ok(request, id):
    name = request.POST['name']
    addr = request.POST['addr']
    address = Address.objects.get(id=id)
    address.name = name
    address.addr = addr
    nowDatetime = timezone.now().strftime('%Y-%m-%d %H:%M:%S')
    address = Address(name=name, addr=addr, rdate=nowDatetime)
    address.rdate = nowDatetime
    address.save()
    return HttpResponseRedirect(reverse('list'))