import { ObjectId } from "mongoose";

export default interface OrderDetail {
	order_id: ObjectId;
	product_id: ObjectId;
	quantity: number;
}
