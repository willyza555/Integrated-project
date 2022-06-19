import { Order, OrderDetail, Restaurant } from "@/database/models";
import { CreateOrderPost } from "@/interface/api/Order";
import { Request } from "express";
import { genericError, infoResponse } from "./Handler";
import { isLogin } from "./Utils";

export const CreateOrder = async (req: Request, body:CreateOrderPost) => {
    try {
        if (!isLogin(req)) {
            return genericError(
                "Unauthorize: Login is required to do function",
                400
            );
        }
        try {
            const new_order = await Order.create({
                ...body,
            });
            await OrderDetail.create({
                order_id: new_order._id,
                ...body.detail,
            });
        } catch (error) {
          return  genericError(error.message, 400);
        }
        return infoResponse(null, "Create order success", 201);
    } catch (error) {
        return genericError(error.message, 500);
    }
}

export const GetOrder = async (req: Request) => {
    try {
        if (!isLogin(req)) {
            return genericError(
                "Unauthorize: Login is required to do function",
                400
            );
        }
        const user_id = req.user.user_id;
        const res_id = await Restaurant.findOne({owner_id: user_id}).select("_id").exec();
        const orders = await Order.find({res_id}).exec();
        return infoResponse(orders, "Get order success", 200);
    } catch (error) {
        return genericError(error.message, 500);
    }
}

export const DeleteOrder = async (req: Request) => {
    try {
        if (!isLogin(req)) {
            return genericError(
                "Unauthorize: Login is required to do function",
                400
            );
        }
        const order_id = req.params.order_id;
        await Order.deleteOne({_id: order_id}).exec();
        return infoResponse(null, "Delete order success", 200);
    } catch (error) {
        return genericError(error.message, 500);
    }
}


