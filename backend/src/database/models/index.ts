import Restaurant from "@/interface/models/Restaurant";
import User from "@/interface/models/User";
import Product from "@/interface/models/Product";
import Order from "@/interface/models/Order";
import OrderDetail from "@/interface/models/OrderDetail";
import mongoose from "mongoose";

import {
	productSchema,
	restaurantSchema,
	userSchema,
	orderSchema,
	orderDetailSchema,
} from "./schema";

export const User = mongoose.model<User>("User", userSchema, "User");
export const Restaurant = mongoose.model<Restaurant>(
	"Restaurant",
	restaurantSchema,
	"restaurant"
);
export const Product = mongoose.model<Product>(
	"Products",
	productSchema,
	"Product"
);
export const Order = mongoose.model<Order>("Order", orderSchema, "Order");
export const OrderDetail = mongoose.model<OrderDetail>(
	"OrderDetail",
	orderDetailSchema,
	"OrderDetail"
);
