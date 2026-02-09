import pytest
from playwright.sync_api import Page, expect
from django.contrib.auth.models import User
from src.core.models import Sport

@pytest.mark.django_db
def test_admin_creation_sport_scenario(page: Page, live_server):
    
    password = "password123"
    admin_user = User.objects.create_superuser(
        username="admin_test", 
        email="admin@test.com", 
        password=password
    )

    page.goto(f"{live_server.url}/admin/login/")
    
    page.fill('input[name="username"]', "admin_test")
    page.fill('input[name="password"]', password)
    page.click('input[type="submit"]')

    expect(page.get_by_role("heading", name="Site d’administration")).to_be_visible()

    page.goto(f"{live_server.url}/admin/core/sport/add/") 
    
    page.fill('input[name="nom"]', "Rugby")
    page.select_option('select[name="caracteristique"]', "EQUIPE") 
    
    page.click('input[name="_save"]')

    expect(page.locator('.success')).to_contain_text("L'objet sport « Rugby (Par Équipe) » a été ajouté avec succès.")
    
    expect(page.locator('#result_list')).to_contain_text("Rugby")