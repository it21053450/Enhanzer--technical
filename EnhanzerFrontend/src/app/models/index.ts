export interface LoginRequest {
  email: string;
  password: string;
}

export interface LoginResponse {
  message: string;
  token: string;
  email: string;
}

export interface Location {
  id: number;
  location_Code: string;
  location_Name: string;
}

export interface PurchaseBillItem {
  item: string;
  batch: string;
  standardCost: number;
  standardPrice: number;
  quantity: number;
  discount: number;
  totalCost: number;
  totalSelling: number;
}

export interface PurchaseBillSummary {
  totalItems: number;
  totalQuantity: number;
}
