#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <string>

#include "bitmap_image.hpp"

void cartesian()
{
   {
      cartesian_canvas canvas(1000, 1000);

      if (!canvas)
      {
         printf("cartesian() - Error - Failed to instantiate cartesian canvas(1000x1000) [1]\n");
         return;
      }

      canvas.rectangle(canvas.min_x(), canvas.min_y(), canvas.max_x(), canvas.max_y());

      canvas.horiztonal_line_segment(canvas.min_x(), canvas.max_x(), -400.0);

      canvas.line_segment(-500.0, 600.0, 600.0, -500.0);

      canvas.pen_width(3);

      for (std::size_t i = 0; i < 160; i++)
      {
         std::size_t c_idx = i % (sizeof(palette_colormap) / sizeof(rgb_t));

         canvas.pen_color(palette_colormap[c_idx].red, palette_colormap[c_idx].green, palette_colormap[c_idx].blue);

         canvas.circle(0.0, 0.0, 3.0 * i);
      }

      canvas.image().save_image("cartesian_canvas01.bmp");
   }

   {
      static const double pi = 3.14159265358979323846264338327950288419716939937510;

      cartesian_canvas canvas(1000, 1000);

      if (!canvas)
      {
         printf("cartesian() - Error - Failed to instantiate cartesian canvas(1000x1000) [2]\n");
         return;
      }

      canvas.image().set_all_channels(0xFF);

      canvas.pen_width(2);

      unsigned int i = 0;

      for (double x = -500; x < 500; x += 3, ++i)
      {
         std::size_t c_idx = i % (sizeof(palette_colormap) / sizeof(rgb_t));

         canvas.pen_color(palette_colormap[c_idx].red, palette_colormap[c_idx].green, palette_colormap[c_idx].blue);

         double radius = std::max(10.0,std::abs(80.0 * std::sin((1.0 / 80.0) * pi * x)));

         double y = 400.0 * std::sin((1.0 / 200.0) * pi * x);

         canvas.circle(x, y, radius);
      }

      canvas.image().save_image("cartesian_canvas02.bmp");
   }
}

void fractal()
{
   const rgb_t* colormap[4] = {
                                   hsv_colormap,
                                   jet_colormap,
                                 prism_colormap,
                                   vga_colormap
                              };

   const unsigned int fractal_width  = 1200;
   const unsigned int fractal_height =  800;

   {
      bitmap_image fractal_hsv  (fractal_width,fractal_height);
      bitmap_image fractal_jet  (fractal_width,fractal_height);
      bitmap_image fractal_prism(fractal_width,fractal_height);
      bitmap_image fractal_vga  (fractal_width,fractal_height);

      fractal_hsv  .clear();
      fractal_jet  .clear();
      fractal_prism.clear();
      fractal_vga  .clear();

      double    cr,    ci;
      double nextr, nexti;
      double prevr, previ;

      const unsigned int max_iterations = 1000;

      for (unsigned int y = 0; y < fractal_height; ++y)
      {
         for (unsigned int x = 0; x < fractal_width; ++x)
         {
            cr = 1.5 * (2.0 * x / fractal_width  - 1.0) - 0.5;
            ci =       (2.0 * y / fractal_height - 1.0);

            nextr = nexti = 0;
            prevr = previ = 0;

            for (unsigned int i = 0; i < max_iterations; i++)
            {
               prevr = nextr;
               previ = nexti;

               nextr =     prevr * prevr - previ * previ + cr;
               nexti = 2 * prevr * previ + ci;

               if (((nextr * nextr) + (nexti * nexti)) > 4)
               {
                  if (max_iterations != i)
                  {
                     double z = sqrt(nextr * nextr + nexti * nexti);

                     #define log2(x) (std::log(1.0 * x) / std::log(2.0))

                     unsigned int index = static_cast<unsigned int>
                        (1000.0 * log2(1.75 + i - log2(log2(z))) / log2(max_iterations));
                     #undef log2

                     rgb_t c0 = colormap[0][index];
                     rgb_t c1 = colormap[1][index];
                     rgb_t c2 = colormap[2][index];
                     rgb_t c3 = colormap[3][index];

                     fractal_hsv  .set_pixel(x, y, c0.red, c0.green, c0.blue);
                     fractal_jet  .set_pixel(x, y, c1.red, c1.green, c1.blue);
                     fractal_prism.set_pixel(x, y, c2.red, c2.green, c2.blue);
                     fractal_vga  .set_pixel(x, y, c3.red, c3.green, c3.blue);
                  }

                  break;
               }
            }
         }
      }

      fractal_hsv  .save_image("mandelbrot_set_hsv.bmp"  );
      fractal_jet  .save_image("mandelbrot_set_jet.bmp"  );
      fractal_prism.save_image("mandelbrot_set_prism.bmp");
      fractal_vga  .save_image("mandelbrot_set_vga.bmp"  );
   }

   {
      bitmap_image fractal_hsv  (fractal_width,fractal_height);
      bitmap_image fractal_jet  (fractal_width,fractal_height);
      bitmap_image fractal_prism(fractal_width,fractal_height);
      bitmap_image fractal_vga  (fractal_width,fractal_height);

      fractal_hsv  .clear();
      fractal_jet  .clear();
      fractal_prism.clear();
      fractal_vga  .clear();

      const unsigned int max_iterations = 300;

      const double cr = -0.70000;
      const double ci =  0.27015;

      double prevr, previ;

      for (unsigned int y = 0; y < fractal_height; ++y)
      {
         for (unsigned int x = 0; x < fractal_width; ++x)
         {
            double nextr = 1.5 * (2.0 * x / fractal_width  - 1.0);
            double nexti =       (2.0 * y / fractal_height - 1.0);

            for (unsigned int i = 0; i < max_iterations; i++)
            {
               prevr = nextr;
               previ = nexti;

               nextr =     prevr * prevr - previ * previ + cr;
               nexti = 2 * prevr * previ + ci;

               if (((nextr * nextr) + (nexti * nexti)) > 4)
               {
                  if (max_iterations != i)
                  {
                     unsigned int index = static_cast<int>((1000.0 * i) / max_iterations);

                     rgb_t c0 = colormap[0][index];
                     rgb_t c1 = colormap[1][index];
                     rgb_t c2 = colormap[2][index];
                     rgb_t c3 = colormap[3][index];

                     fractal_hsv  .set_pixel(x, y, c0.red, c0.green, c0.blue);
                     fractal_jet  .set_pixel(x, y, c1.red, c1.green, c1.blue);
                     fractal_prism.set_pixel(x, y, c2.red, c2.green, c2.blue);
                     fractal_vga  .set_pixel(x, y, c3.red, c3.green, c3.blue);
                  }

                  break;
               }
            }
         }
      }

      fractal_hsv  .save_image("julia_set_hsv.bmp"  );
      fractal_jet  .save_image("julia_set_jet.bmp"  );
      fractal_prism.save_image("julia_set_prism.bmp");
      fractal_vga  .save_image("julia_set_vga.bmp"  );
   }
}

extern "C"
void build_bitmap(int choosen)
{
   switch(choosen) {
      case 1:
         cartesian();
         break;
      case 2:
         fractal();
         break;
      default:
         break;
   }
}

int main(int argc, char **argv)
{
   int choosen = 0;
   if(argc > 1)
   {
      choosen = std::atoi(argv[1]);
   }

   build_bitmap(choosen);
   
   return 0;
}
