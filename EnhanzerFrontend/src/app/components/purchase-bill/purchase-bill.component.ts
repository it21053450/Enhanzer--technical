import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { Location, PurchaseBillItem, PurchaseBillSummary } from '../../models';
import { LocationService } from '../../services/location.service';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-purchase-bill',
  templateUrl: './purchase-bill.component.html',
  styleUrls: ['./purchase-bill.component.css']
})
export class PurchaseBillComponent implements OnInit {
  purchaseForm!: FormGroup;
  items: PurchaseBillItem[] = [];
  locations: Location[] = [];
  filteredLocations: Location[] = [];
  summary: PurchaseBillSummary = { totalItems: 0, totalQuantity: 0 };
  errorMessage = '';
  successMessage = '';

  fruits = ['Mango', 'Apple', 'Banana', 'Orange', 'Grapes', 'Kiwi', 'Strawberry'];

  constructor(
    private formBuilder: FormBuilder,
    private locationService: LocationService,
    private authService: AuthService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.createForm();
    this.loadLocations();
  }

  createForm(): void {
    this.purchaseForm = this.formBuilder.group({
      item: ['', Validators.required],
      batch: ['', Validators.required],
      standardCost: [0, [Validators.required, Validators.min(0)]],
      standardPrice: [0, [Validators.required, Validators.min(0)]],
      quantity: [1, [Validators.required, Validators.min(1)]],
      discount: [0, [Validators.required, Validators.min(0), Validators.max(100)]]
    });
  }

  loadLocations(): void {
    this.locationService.getLocations().subscribe({
      next: (data) => {
        this.locations = data;
        this.filteredLocations = data;
      },
      error: (error) => {
        this.errorMessage = 'Failed to load locations';
      }
    });
  }

  filterLocations(event: any): void {
    const query = event.target.value.toLowerCase();
    if (!query) {
      this.filteredLocations = this.locations;
    } else {
      this.filteredLocations = this.locations.filter(loc =>
        loc.location_Name.toLowerCase().includes(query)
      );
    }
  }

  calculateTotalCost(): number {
    const standardCost = this.purchaseForm.get('standardCost')?.value || 0;
    const quantity = this.purchaseForm.get('quantity')?.value || 0;
    const discount = this.purchaseForm.get('discount')?.value || 0;

    const subTotal = standardCost * quantity;
    const discountAmount = (subTotal * discount) / 100;
    return subTotal - discountAmount;
  }

  calculateTotalSelling(): number {
    const standardPrice = this.purchaseForm.get('standardPrice')?.value || 0;
    const quantity = this.purchaseForm.get('quantity')?.value || 0;
    return standardPrice * quantity;
  }

  onAddClick(): void {
    this.errorMessage = '';
    this.successMessage = '';

    if (this.purchaseForm.invalid) {
      this.errorMessage = 'Please fill all required fields with valid values';
      return;
    }

    const formValue = this.purchaseForm.value;
    const selectedBatch = this.locations.find(l => l.location_Name === formValue.batch);

    if (!selectedBatch) {
      this.errorMessage = 'Invalid batch selected';
      return;
    }

    const newItem: PurchaseBillItem = {
      item: formValue.item,
      batch: selectedBatch.location_Name,
      standardCost: formValue.standardCost,
      standardPrice: formValue.standardPrice,
      quantity: formValue.quantity,
      discount: formValue.discount,
      totalCost: this.calculateTotalCost(),
      totalSelling: this.calculateTotalSelling()
    };

    this.items.push(newItem);
    this.updateSummary();
    this.resetForm();
    this.successMessage = 'Item added successfully!';
    setTimeout(() => this.successMessage = '', 3000);
  }

  deleteItem(index: number): void {
    this.items.splice(index, 1);
    this.updateSummary();
  }

  updateSummary(): void {
    this.summary.totalItems = this.items.length;
    this.summary.totalQuantity = this.items.reduce((sum, item) => sum + item.quantity, 0);
  }

  resetForm(): void {
    this.purchaseForm.reset({
      item: '',
      batch: '',
      standardCost: 0,
      standardPrice: 0,
      quantity: 1,
      discount: 0
    });
  }

  logout(): void {
    this.authService.logout();
  }
}
