import { ObjectId } from "mongoose";

export interface ProductPost {
	name: string;
	price: number;
}

export interface ProductPatch {
	name: string;
	price: number;
}
