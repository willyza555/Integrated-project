import { ObjectId } from "mongoose";

export default interface Order {
	res_id: ObjectId;
	customer_id: ObjectId;
	total: number;
	rider_id: ObjectId;
	seq: number;
	isDone: boolean;
}
