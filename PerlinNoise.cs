using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DarkBoxEngine
{
    class PerlinNoise
    {
        private int width;
        private int height;
        private int octave;
        private double[,] Noise;
        private double persistance = 0.5;
        private double amplitude = 1.0;
        private double totalAmplitude = 0.0;

        public PerlinNoise(int width, int height, int octave)
        {
            this.width = width;
            this.height = height;
            this.Noise = new double[width, height];
            this.octave = octave;
            randomNoise();
        }

        private double[,] randomNoise()
        {

            Random random = new Random();
            for (int i = 0; i < Noise.GetLength(0); i++)
            {
                for (int j = 0; j < Noise.GetLength(1); j++)
                {
                    var noiseVal=random.NextDouble();
                    Noise[i, j] = noiseVal;
                }
            }
            return Noise;
        }

        private double[][,] smoothNoise()
        {
            double[][,] smoothNoise = new double[octave][,];

            for (int i = 0; i < octave; i++)
            {
                smoothNoise[i] =  GenerateSmoothNoise(Noise) ;
            }

            return smoothNoise;
        }

        private double[,] GenerateSmoothNoise(double[,] inputNoise)
        {
            var samplePeriod = 1 << octave;
            var sampleFrequency = 1.0 / samplePeriod;
            double[,] smoothNoise= new double[width, height]; ;

            for(int i = 0; i < width; i++)
            {
                var sample_i0 = (i / samplePeriod) * samplePeriod;
                var sample_i1 = (sample_i0 + samplePeriod) % width;
                var horizontal_blend = (i - sample_i0) * sampleFrequency;

                for (int j = 0; j < height; j++)
                {
                    var sample_j0 = (j / samplePeriod) * samplePeriod;
                    var sample_j1 = (sample_j0 + samplePeriod) % height;
                    var vertical_blend = (j - sample_j0) * sampleFrequency;
                    var top = Lerp(inputNoise[sample_i0, sample_j0], inputNoise[sample_i1,sample_j0], horizontal_blend);
                    var bottom = Lerp(inputNoise[sample_i0, sample_j1], inputNoise[sample_i1, sample_j1], horizontal_blend);
                    smoothNoise[i, i] = Lerp(top, bottom, vertical_blend);
                }
            }

            return smoothNoise;
        }

        double Lerp(double firstFloat, double secondFloat, double by)
        {
            return firstFloat * by + secondFloat * (1 - by);
        }


    }
}
