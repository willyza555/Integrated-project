import { Order, OrderDetail, Product, Restaurant } from "@/database/models";
import { CreateOrderPost, OrderUpdate } from "@/interface/api/Order";
import { Request } from "express";
import { ObjectId } from "mongoose";
import { genericError, infoResponse } from "./Handler";
import { isLogin } from "./Utils";

export const CreateOrder = async (req: Request, body: CreateOrderPost) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
		const product1 = await Product.findOne({
			_id: body.detail[0].product_id,
		}).exec();
		const product2 = await Product.findOne({
			_id: body.detail[1].product_id,
		}).exec();

		const total =
			product1.price * body.detail[0].quantity +
			product2.price * body.detail[1].quantity;
		try {
			const new_order = await Order.create({
				customer_id: user_id,
				res_id: product1.res_id,
				total: total,
				...body,
			});
			await OrderDetail.create({
				order_id: new_order._id,
				...body.detail[0],
			});
			await OrderDetail.create({
				order_id: new_order._id,
				...body.detail[1],
			});
		} catch (error) {
			return genericError(error.message, 400);
		}
		return infoResponse(null, "Create order success", 201);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetOrders = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
		const res_id = await Restaurant.findOne({ owner_id: user_id })
			.select("_id")
			.exec();
		const orders = await Order.find({ res_id }).exec();
		return infoResponse(orders, "Get order success", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetOrder = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const order_id = req.params.order_id;
		const user_id = req.user.user_id;
		const res_id = await Restaurant.findOne({ owner_id: user_id })
			.select("_id")
			.exec();
		const order = await Order.findOne({ _id: order_id, res_id }).exec();
		return infoResponse(order, "Get order success", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const DeleteOrder = async (req: Request, order_id: ObjectId) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		await Order.deleteOne({ _id: order_id }).exec();
		return infoResponse(null, "Delete order success", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const UpdateOrder = async (req: Request, data: OrderUpdate) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		try {
			await OrderDetail.updateOne(
				{ order_id: data.order_id, product_id: data.detail.product_id },
				{ $set: { quantity: data.detail.quantity } }
			).exec();

			await Order.updateOne(
				{
					_id: data.order_id,
				},
				{
					$set: { total: data.total },
				}
			);
		} catch (error) {
			return genericError(error.message, 400);
		}
		return infoResponse(null, "Order updated!", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const OrderDone = async (req: Request, order_id: ObjectId) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		try {
			await Order.updateOne(
				{ _id: order_id },
				{ $set: { isDone: true } }
			).exec();
		} catch (error) {
			return genericError(error.message, 400);
		}
		return infoResponse(null, "Order done!", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};
