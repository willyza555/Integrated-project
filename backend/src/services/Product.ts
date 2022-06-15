import { genericError, infoResponse } from "./Handler";
import { isLogin } from "./Utils";
import { Request } from "express";
import { Product, Restaurant } from "@/database/models";
import { ProductPatch, ProductPost } from "@/interface/api/Product";
import { Types } from "mongoose";

export const AddProduct = async (req: Request, body: ProductPost) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
		try {
			const new_product = await Product.create({
				res_id: body.res_id,
				name: body.name,
				price: body.price,
			});
		} catch (e) {
			return genericError(e.message, 400);
		}
		return infoResponse(null, "offer added!", 201);
	} catch (e) {
		return genericError(e.message, 500);
	}
};

export const UpdateProduct = async (
	req: Request,
	body: ProductPatch,
	product_id: Types.ObjectId
) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		const restaurant = await Restaurant.findOne({
			owner_id: user_id,
		}).exec();

		if (restaurant == null) {
			return genericError(
				"Unauthorize: User is not own this restaurant",
				400
			);
		}

		try {
			await Product.updateOne(
				{ _id: product_id },
				{ $set: { ...body } }
			).exec();
		} catch (error) {
			return genericError(error.message, 400);
		}

		return infoResponse(null, "product updated!", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const DeleteProduct = async (
	req: Request,
	product_id: Types.ObjectId
) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		const restaurant = await Restaurant.findOne({
			owner_id: user_id,
		}).exec();

		if (restaurant == null) {
			return genericError(
				"Unauthorize: User is not own this restaurant",
				400
			);
		}

		try {
			await Product.deleteOne({ _id: product_id }).exec();
		} catch (error) {
			return genericError(error.message, 400);
		}
		return infoResponse(null, "product deleted!", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetProduct = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		const restaurant = await Restaurant.findOne({
			owner_id: user_id,
		}).exec();

		if (restaurant == null) {
			return genericError(
				"Unauthorize: User is not own this restaurant",
				400
			);
		}

		const products = await Product.find({ res_id: restaurant._id }).exec();

		return infoResponse(products, "products fetched!", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetProductById = async (
	req: Request,
	product_id: Types.ObjectId
) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}

		const user_id = req.user.user_id;

		const restaurant = await Restaurant.findOne({
			owner_id: user_id,
		}).exec();

		if (restaurant == null) {
			return genericError(
				"Unauthorize: User is not own this restaurant",
				400
			);
		}

		const product = await Product.findOne({ _id: product_id }).exec();

		return infoResponse(product, "product fetched!", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};
