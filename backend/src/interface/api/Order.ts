import { ObjectId } from "mongoose";

export interface CreateOrderPost {
	customer_id: ObjectId;
	total: number;
	rider_id: ObjectId;
	detail: {
		product_id: ObjectId;
		quantity: number;
	};
	isDone: false;
}

export interface OrderGet {
	res_id: ObjectId;
	order_id: ObjectId;
	total: number;
	detail: {
		product_id: ObjectId;
		quantity: number;
	};
	isDone: boolean;
}

export interface OrderUpdate {
	order_id: ObjectId;
	total: number;
	detail: {
		product_id: ObjectId;
		quantity: number;
	};
}
