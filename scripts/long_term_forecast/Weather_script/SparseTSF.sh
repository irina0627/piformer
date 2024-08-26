if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

model_name=SparseTSF

root_path_name=./dataset/weather/
data_path_name=weather.csv
model_id_name=weather
data_name=custom

seq_len=96
for pred_len in 96
do
  python -u run.py \
    --task_name long_term_forecast \
    --is_training 1 \
    --root_path $root_path_name \
    --data_path $data_path_name \
    --model_id $model_id_name'_'$seq_len'_'$pred_len \
    --model $model_name \
    --data $data_name \
    --features M \
    --seq_len $seq_len \
    --pred_len $pred_len \
    --period_len 4 \
    --enc_in 21 \
    --train_epochs 30 \
    --patience 5 \
    --itr 1 --batch_size 256 --learning_rate 0.001
done
