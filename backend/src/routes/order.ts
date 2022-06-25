import { CreateOrderPost, OrderUpdate } from "@/interface/api/Order";
import { responseHandler } from "@/services/Handler";
import {
	CreateOrder,
	DeleteOrder,
	GetHistoryOrders,
	GetOrder,
	GetOrders,
	OrderDone,
	UpdateOrder,
} from "@/services/Order";
import express from "express";
import { ObjectId } from "mongoose";

const orderRoute = express.Router();

orderRoute.post("/", async (req, res) => {
	const data: CreateOrderPost = req.body;
	return responseHandler(res, await CreateOrder(req, data));
});

orderRoute.delete("/delete", async (req, res) => {
	const order_id: ObjectId = req.body.order_id;
	return responseHandler(res, await DeleteOrder(req, order_id));
});

orderRoute.get("/", async (req, res) => {
	return responseHandler(res, await GetOrders(req));
});

orderRoute.get("/history", async (req, res) => {
	return responseHandler(res, await GetHistoryOrders(req));
});

orderRoute.get("/:order_id", async (req, res) => {
	return responseHandler(res, await GetOrder(req));
});

orderRoute.patch("/update", async (req, res) => {
	const data: OrderUpdate = req.body;
	return responseHandler(res, await UpdateOrder(req, data));
});

orderRoute.patch("/done", async (req, res) => {
	const order_id: ObjectId = req.body.order_id;
	return responseHandler(res, await OrderDone(req, order_id));
});

export default orderRoute;
