import {
	Counter,
	Order,
	OrderDetail,
	Product,
	Restaurant,
	User
} from "@/database/models";
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
		const orderCounter = await Counter.findOne({ type: "order" }).exec();
		await Counter.updateOne(
			{ type: "order" },
			{ $set: { seq: orderCounter.seq + 1 } }
		);
		const newCounter = await Counter.findOne({ type: "order" }).exec();
		try {
			const new_order = await Order.create({
				customer_id: user_id,
				res_id: product1.res_id,
				total: total,
				seq: newCounter.seq,
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
		
		const orders = await Order.find({ res_id, isDone: false }).exec();
		
		
		const customer = await User.find({ _id: { $in: orders.map((o) => o.customer_id) }, isRestaurant : false }).select(["firstname","lastname","tel"]).exec();
		
		return await infoResponse({orders,customer}, "Get order success", 200);
		
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const GetOldOrder = async (req: Request) => {
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

		const order = await Order.findOne({
			_id: order_id,
			res_id,
			isDone: true,
		}).exec();
		const order_detail = await OrderDetail.find({
			order_id,
		}).exec();
		const result = { order, order_detail };
		return infoResponse(result, "Get order success", 200);
			} catch (error) {
		return genericError(error.message, 500);
	}
 }
export const GetHistoryOrders = async (req: Request) => {
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
		
		const orders = await Order.find({ res_id, isDone: true }).exec();
		
		
		const customer = await User.find({ _id: { $in: orders.map((o) => o.customer_id) }, isRestaurant : false }).select(["firstname","lastname","tel"]).exec();
		
		return await infoResponse({orders,customer}, "Get order success", 200);
		
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
		const order = await Order.findOne({
			_id: order_id,
			res_id,
			isDone: false,
		}).exec();
		const order_detail = await OrderDetail.find({ order_id }).exec();
		const result = { order, order_detail };
		return infoResponse(result, "Get order success", 200);
	} catch (error) {
		return genericError(error.message, 500);
	}
};

export const DeleteOrder = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const order_id = req.params.order_id;
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
				{
					order_id: data.order_id,
					product_id: data.detail[0].product_id,
				},
				{ $set: { quantity: data.detail[0].quantity } }
			).exec();
			const product1 = await Product.findOne({
				_id: data.detail[0].product_id,
			}).exec();
			const product2 = await Product.findOne({
				_id: data.detail[1].product_id,
			}).exec();

			const total =
				product1.price * data.detail[0].quantity +
				product2.price * data.detail[1].quantity;

			await Order.updateOne(
				{
					_id: data.order_id,
				},
				{
					$set: { total: total },
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

export const OrderDone = async (req: Request) => {
	try {
		if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const order_id = req.params.order_id;
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
