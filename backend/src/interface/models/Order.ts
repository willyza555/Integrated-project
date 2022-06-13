import { ObjectId } from "mongoose";

export default interface Order {
	order_id: ObjectId;
	customer_id: ObjectId;
	total: number;
	rider_id: ObjectId;
}
