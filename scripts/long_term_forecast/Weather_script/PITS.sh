if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

export CUDA_VISIBLE_DEVICES=0  # 첫 번째 GPU만 사용하도록 설정
seq_len=96
model_name=PITS
root_path_name=./dataset/weather/
data_path_name=weather.csv
model_id_name=weather
data_name=custom

for pred_len in 96 192
do
    python -u run.py \
      --task_name long_term_forecast \
      --is_training 1 \
      --root_path $root_path_name \
      --data_path $data_path_name \
      --model_id $model_id_name_$seq_len'_'$pred_len \
      --model $model_name \
      --data $data_name \
      --features M \
      --seq_len $seq_len \
      --pred_len $pred_len \
      --enc_in 21 \
      --d_model 128 \
      --patch_len 12\
      --stride 6\
      --train_epochs 20\
      --patience 5\
      --itr 1 --batch_size 128 --learning_rate 0.0001 
      # >logs/LongForecasting/$model_name'_'$model_id_name'_'$seq_len'_'$pred_len.log 
done