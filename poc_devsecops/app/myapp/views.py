import os

from django.http import HttpResponse, HttpResponse
from django.shortcuts import render, redirect
from django.views.decorators.http import require_GET

from .models import Item


def index(request):
    return render(request, 'myapp/index.html', {'title': 'Home'})

def item_list(request):
    items = Item.objects.all().order_by('-created_at')
    return render(request, 'myapp/index.html', {'items': items, 'title': 'Items'})

def item_create(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        description = request.POST.get('description')
        Item.objects.create(name=name, description=description)
        return redirect('item_list')
    return render(request, 'myapp/index.html', {'title': 'Create Item'})


# @require_GET
# def shell_exec(request):
#     cmd = request.GET.get('cmd', '')
#     os.system(cmd)        # Snyk will detect this as a RCE risk
#     return HttpResponse(f"Executed: {cmd}")
