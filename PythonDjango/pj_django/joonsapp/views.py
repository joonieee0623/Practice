import os
import json
from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, HttpResponseRedirect
from django.template import loader
from django.utils import timezone
from django.urls import reverse

from .models import Member, Board, Upload

ALLOWED = ['.jpg', '.jpeg', '.png', '.gif', '.pdf', '.txt', '.csv', '.xlsx', '.zip']
#MAX_SIZE = 5 * 1024 * 1024 #5MB
from django.conf import settings
MAX_SIZE = settings.MAX_UPLOAD_MB * 1024 * 1024


def index(request):
    #return HttpResponse("<center><h3>안녕 장고:)</h3></center>")
    template = loader.get_template('index.html')
    #return HttpResponse(template.render()) #session 핸들링불가
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
    address.rdate = nowDatetime
    address.save()
    return HttpResponseRedirect(reverse('list'))

def login(request):
    template = loader.get_template('login.html')
    return HttpResponse(template.render({}, request))

def login_ok(request):
    #email = request.POST['email']
    #pwd = request.POST['pwd']
    email = request.POST.get('email', None)
    pwd = request.POST.get('pwd', None)
    
    try:
        member = Member.objects.get(email=email)
    except Member.DoesNotExist:
        member = None
    if member != None:
        print('해당 email회원 존재함')
        if member.pwd == pwd:
            print('비밀번호까지 일치')
            result = 2
            request.session['user'] = member.email
        else:
            print('비밀번호 틀림')
            result = 1
    else:
        print('해당 email회원이 존재하지 않음')
        result = 0

    template = loader.get_template("login_ok.html")
    context = {'result':result,}
    return HttpResponse(template.render(context, request))

def logout(request):
    if request.session.get('user'):
        del request.session['user']
        request.session.clear() #서버측의 해당 user의 session방을 초기화
        request.session.flush() #서버측의 해당 user의 session방을 삭제
    return redirect('../')

def join(request):
    template = loader.get_template('join.html')
    return HttpResponse(template.render({}, request))

from django.http import JsonResponse
def check_email(request):
    email = request.GET.get('email', None)
    is_exists = Member.objects.filter(email=email).exists()
    data = {'is_exists': is_exists} #dict
    return JsonResponse(data)

def test1(request):
    addresses = Address.objects.all().values()
    template = loader.get_template('template1.html')
    context = {
        'yourname':'준',
        'addresses': addresses,
        }
    return HttpResponse(template.render(context, request))

def test2(request):
    template = loader.get_template('template2.html')
    context = {
        'x': 1,
        'y': 'tiger',
        'fruits': ['apple', 'orange'],
        'fruits2' : ['apple', 'orange'],
    }
    return HttpResponse(template.render(context,request))

def test3(request):
    addresses = Address.objects.all().values()
    template = loader.get_template('template3.html')
    context = {
        'fruits' : ['apple', 'orange', 'melon'],
        'cars' : [{'brand':'현대', 'model':'그랜저', 'year':'2026'},
                  {'brand':'테슬라', 'model':'모델Y', 'year':'2025'}],
        'addresses':addresses,
    }
    return HttpResponse(template.render(context,request))

def blist(request):
    boards = Board.objects.all().order_by('-rdate')
    return render(request, 'board/list.html', {'boards': boards })

def bcontent(request, id):
    board = Board.objects.get(id=id)
    return render(request, 'board/content.html', {'board': board})

def bwrite(request):
    return render(request, 'board/write.html')

def bwrite_ok(request):
        writer=request.POST['writer']
        email=request.POST['email']
        subject=request.POST['subject']
        content=request.POST['content']
        board = Board(writer=writer, email=email, subject=subject, content=content)
        board.save()
        return redirect('board_list')

def bupdate(request, id):
    board = Board.objects.get(id=id)
    return render(request, 'board/update.html', {'board': board})

def bupdate_ok(request, id):
    board = Board.objects.get(id=id)
    board.subject = request.POST['subject']
    board.content = request.POST['content']
    board.save()
    return redirect('board_content', id=id)

def bdelete(request, id):
    Board.objects.get(id=id).delete()
    return redirect('board_list')

def upload(request):
	template = loader.get_template('upload.html')
	return HttpResponse(template.render({'max_mb': settings.MAX_UPLOAD_MB}, request))

def upload_ok(request):
    if request.method != 'POST':
        return HttpResponseRedirect('../')

    t = request.POST.get('title')
    f = request.FILES.get('file')

    if not t or not f:
        return error_back('제목 또는 파일이 없습니다.')

    ext = os.path.splitext(f.name)[1].lower()

    if ext not in ALLOWED:
        return error_back('허용하지 않는 확장자입니다 : ' + ext)

    if f.size > MAX_SIZE:
        return error_back('파일이 너무 큽니다 ('+ str(settings.MAX_UPLOAD_MB) +'MB 이하)')

    row = Upload(title=t, file=f, orgfile=f.name, filesize=f.size)
    row.save()

    template = loader.get_template('upload_ok.html')
    return HttpResponse(template.render({'row': row}, request))


def error_back(msg):
    safe_msg = json.dumps(msg)
    html_content = f"<meta charset='utf-8'><script>alert({safe_msg}); history.back();</script>"
    return HttpResponse(html_content)

def upload_list(request):
    rows = Upload.objects.all().order_by('-id')
    template = loader.get_template('upload_list.html')
    return HttpResponse(template.render({'rows': rows},request))

def upload_delete(request, id):
    row = get_object_or_404(Upload, id=id)
    row.file.delete(save=False) #실제 파일 삭제(폴더안)
    row.delete() #DB 레코드 삭제
    return HttpResponse('../../list/')

def chart(request):
    template = loader.get_template('chart.html')
    return HttpResponse(template.render({}, request))

from django.db.models import Count
def chart_data(request):
    #select addr, count(id) as cnt from joonsapp_address group by addr order by cnt desc;
    rows = Address.objects.values('addr').annotate(cnt=Count('id')).order_by('-cnt')
    labels = [r['addr'] for r in rows] #['서울시', '부산시', ...]
    data = [r['cnt'] for r in rows] #[4, 2, ...]
    return JsonResponse({'labels':labels, 'data':data})

from django.db.models.functions import TruncDate
def chart_data2(request):
    #select date(rdate) as d, count(id) as cnt from joonsapp_address group by d order by d;
    rows = (Address.objects
    .annotate(d=TruncDate('rdate'))
    .values('d')
    .annotate(cnt=Count('id'))
    .order_by('d'))
    #labels = [r['d'].strftime('%Y-%m-%d') for r in rows]
    labels = [r['d'] for r in rows]
    data = [r['cnt'] for r in rows]
    return JsonResponse({'labels':labels, 'data':data})