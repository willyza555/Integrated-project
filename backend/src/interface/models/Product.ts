import { ObjectId } from "mongoose";

export default interface Product {
	product_id: ObjectId;
	res_id: ObjectId;
	name: string;
	price: number;
}
