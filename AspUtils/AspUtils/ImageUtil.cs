using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;

namespace AspUtils
{
    public class ImageUtil
    {

        public static Bitmap GetBitmapFromFile(string path)
        {
            var ms = new MemoryStream(File.ReadAllBytes(path)); // Don't use using!!
            return (Bitmap)Image.FromStream(ms);
        }


        public static Bitmap GetBitmapFromStream(Stream Stream)
        {
            return (Bitmap)Image.FromStream(Stream);
        }

        public static Bitmap GetBitmapFromStream(MemoryStream Stream)
        {
            return (Bitmap)Image.FromStream(Stream);
        }

        public static void SaveBitmapJpeg(Bitmap image, int maxWidth, int maxHeight, int quality, bool MaintainAspectRatio, string filePath)
        {
            // New width and height based on aspect ratio
            int newWidth;
            int newHeight;

            if (MaintainAspectRatio)
            {
                // Get the image's original width and height
                int originalWidth = image.Width;
                int originalHeight = image.Height;

                // To preserve the aspect ratio
                float ratioX = (float)maxWidth / (float)originalWidth;
                float ratioY = (float)maxHeight / (float)originalHeight;
                float ratio = Math.Min(ratioX, ratioY);

                newWidth = (int)(originalWidth * ratio);
                newHeight = (int)(originalHeight * ratio);
            }
            else
            {
                newWidth = maxWidth;
                newHeight = maxHeight;
            }

            // Convert other formats (including CMYK) to RGB.
            Bitmap newImage = new Bitmap(newWidth, newHeight, PixelFormat.Format24bppRgb);
            try
            {
                // Draws the image in the specified size with quality mode set to HighQuality
                using (Graphics graphics = Graphics.FromImage(newImage))
                {
                    graphics.CompositingQuality = CompositingQuality.HighQuality;
                    graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    graphics.SmoothingMode = SmoothingMode.HighQuality;
                    graphics.DrawImage(image, 0, 0, newWidth, newHeight);
                }

                // Get an ImageCodecInfo object that represents the JPEG codec.
                ImageCodecInfo imageCodecInfo = GetEncoderInfo(ImageFormat.Jpeg);

                // Create an Encoder object for the Quality parameter.
                Encoder encoder = Encoder.Quality;

                // Create an EncoderParameters object. 
                EncoderParameters encoderParameters = new EncoderParameters(1);

                // Save the image as a JPEG file with quality level.
                EncoderParameter encoderParameter = new EncoderParameter(encoder, quality);
                encoderParameters.Param[0] = encoderParameter;
                newImage.Save(filePath, imageCodecInfo, encoderParameters);
            }
            catch
            {
            }
            newImage.Dispose();
        }

        /// <summary>
        /// Method to get encoder infor for given image format.
        /// </summary>
        /// <param name="format">Image format</param>
        /// <returns>image codec info.</returns>
        private static ImageCodecInfo GetEncoderInfo(ImageFormat format)
        {
            return ImageCodecInfo.GetImageDecoders().SingleOrDefault(c => c.FormatID == format.Guid);
        }

    }
}
