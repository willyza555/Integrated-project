import { Restaurant } from "@/database/models";
import { RestaurantPost } from "@/interface/api/Restaurant";
import { Request } from "express";
import { genericError, infoResponse } from "./Handler";
import { isLogin } from "./Utils";

export const createRestautant = async (req: Request, body:RestaurantPost)=>{
    try {
        if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
        try {
            const NewRestaurant = Restaurant.create({
                owner_id: body.owner_id,
                name: body.name,
                address: body.address,
                location: body.location,
                isOpen: false,
            })
        } catch (e) {
            return genericError(e.message, 400);
        }
        return infoResponse(null, "Restaurant added!", 201);
    } catch (e) {
        return genericError(e.message, 500);
    }
}

export const readRestautant = async (req:Request)=>{
    try {
        if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
        const databaseres = Restaurant.findOne({
            owner_id: user_id
        })
        if(databaseres){
            return infoResponse(databaseres, "Restaurant found!", 200);
        }
    } catch (e) {
        return genericError(e.message, 500);
    }
}

export const deleteRestaurant = async (req:Request)=>{
    try {
        if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;
        const databaseres = Restaurant.deleteOne({
            owner_id: user_id
        })
        if(databaseres){
            return infoResponse(databaseres, "Restaurant found!", 200);
        }
    } catch (e) {
        return genericError(e.message, 500);
    }
}

export const updateRestaurant = async (req:Request)=>{
    try {
        if (!isLogin(req)) {
			return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
		}
		const user_id = req.user.user_id;

        const databaseres = Restaurant.findById({
            owner_id: user_id
        })
        
        if(databaseres == null){
           return genericError(
				"Unauthorize: Login is required to do function",
				400
			);
        }
        
        try{
            await Restaurant.updateOne({
                $set: { isOpen: !(await databaseres).isOpen}
            });
        }
        catch(e){
            return genericError(e.message, 400);
        }
    } catch (e) {
        return genericError(e.message, 500);
    }
}