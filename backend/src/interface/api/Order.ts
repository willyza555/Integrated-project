import { ObjectId } from "mongoose";

export interface CreateOrderPost {
	rider_id: ObjectId;
	detail: OrderDetail[];
	isDone: false;
}

interface OrderDetail {
	product_id: ObjectId;
	quantity: number;
}

export interface OrderGet {
	res_id: ObjectId;
	order_id: ObjectId;
	total: number;
	detail: OrderDetail[];
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
