import { v2 as cloudinary } from "cloudinary";
import dotenv from "dotenv";
dotenv.config();

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
});

async function uploadMultimedia(image, options = {}) {
    try {
        const result = await cloudinary.uploader.upload(image, {
            folder: "FAMILINK/PEOPLE",
            ...options,
        });

        return {
            url: result.secure_url,
            public_id: result.public_id,
            original_filename: result.original_filename,
            resource_type: result.resource_type,
        };
    } catch (error) {
        console.error("❌ Error subiendo imagen a Cloudinary:", error);
        throw error;
    }
}

export { uploadMultimedia };
