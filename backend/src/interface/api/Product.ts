import { ObjectId } from "mongoose";

export interface ProductPost {
	res_id: ObjectId;
	name: string;
	price: number;
}

export interface ProductPatch {
	name: string;
	price: number;
}
