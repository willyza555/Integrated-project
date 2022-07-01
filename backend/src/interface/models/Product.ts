import { ObjectId } from "mongoose";

export default interface Product {
	res_id: ObjectId;
	name: string;
	price: number;
	isSoldOut: boolean;
	picture_url: string;
}
