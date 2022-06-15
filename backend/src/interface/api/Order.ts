import { ObjectId } from "mongoose";

export interface OrderPost {
	customer_id: ObjectId;
	total: number;
	rider_id: ObjectId;
}

export interface OrderDetail {
	order_id: ObjectId;
	product_id: ObjectId;
	quantity: number;
}
