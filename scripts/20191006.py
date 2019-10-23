# util
def fine_tune_model(model_type, task):
    return "model"
def test_model_on_task(model, task):
    return "result"

# models
transformer_model_types = ["bert-base-uncased", "bert-large-uncased", "roberta-large"]
other_model_types = ["Glove", "Word2vec", "LSTM"]
model_types = transformer_model_types + other_model_types
# tasks
task_groups = [
#    ("SST-2", "IMDb"),
#    ("STS-b-headlines", "STS-b-MSRpar"), 
    ("STS-b-MSRvid", "STS-b-images")
]
# run the experiment
for model_type in model_types:
    for task_group in task_groups:
        tuned_models = {}
        for task in task_group:
            tuned_models[task] = fine_tune_model(model_type, task)
        for task in task_group:
            for source_task, model in tuned_models.items():
                result = test_model_on_task(model, task)
                current = "{:20}([{:10}]-[{:10}])".format(model_type, source_task, task)
                result.save("./results/{}".format(current))
                print("{} -> Finished").format(current)

