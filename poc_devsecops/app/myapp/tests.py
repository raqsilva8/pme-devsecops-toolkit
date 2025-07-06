from django.test import TestCase
from .models import Item

class ItemModelTest(TestCase):
    def test_item_creation(self):
        item = Item.objects.create(
            name="Test Item",
            description="This is a test item"
        )
        self.assertEqual(item.name, "Test Item")
        self.assertEqual(item.description, "This is a test item")