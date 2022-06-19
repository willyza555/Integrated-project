import { ObjectId } from "mongoose";

export interface CreateOrderPost {
	customer_id: ObjectId;
	total: number;
	rider_id: ObjectId;
	detail: {
		product_id: ObjectId;
		quantity: number;
	};
}

export interface OrderGet {
	order_id: ObjectId;
	total: number;
	detail: {
		product_id: ObjectId;
		quantity: number;
	};
}
