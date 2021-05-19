# Reproducible Deep Learning
## Extra: TorchServe
[[Official website](https://pytorch.org/serve/)] 


## Prerequisites

1. Uncompress the [ESC-50 dataset](https://github.com/karolpiczak/ESC-50) inside the *data* folder.
2. Install requirements (Java and Python libraries):

```bash
sudo apt install --no-install-recommends -y openjdk-11-jre-headless
pip install torchserve==0.2.0 torch-model-archiver==0.2.0
pip install SoundFile==0.10.3.post1
```

## Instructions

The aim of this exercise is to understand how to serve Pytorch model. In this way, every user can easily use a pre-trained code without the need of train once again from scratch and without to adapt the code for a simple evaluation on a test data sample. 


1. Add to the train.py script a line to save your model once it is trained.

```
torch.save(trainer.model.state_dict(), "model.pth")
```

In this way we can load the learned parameters and use to evaluate on our data.
We need to move all the part/code/data (e.g. model.pth file) to the folder "serve".


2. Then we create an instance of the model copy pasting the class AudioNet from train.py script to a new file named model.py.
> :speech_balloon: This step is not mandatory, but allows you to make things more orderly for possible future changes.


3. Create handler class in a handler.py script. This is the core of this tool.
Basically here we define a class with 4 main functions:
  - initialize: here we define and load the pre-trained model. Moreover we can set other case-specific initial settings;
  - preprocess: this function receive the data and preprocess them before to feed to the net;
  - inference: where the model extract the prediction;
  - postprocess: some final postprocessing operations, like mapping the index of the class to corresponding class name.


4. In the same file (handler.py) define a function named "handle" that instanciate the previous class and use it.

```python
_service = MyHandler()

_service.initialize(context)

data = _service.preprocess(data)

data = _service.inference(data)

data = _service.postprocess(data)
```

Its inputs must be:
  - data: data element, generally as bytearray;
  - context: item that contains some environment info (e.g. presence of gpus or work directory).

```python
if __name__ == "__main__":
    train()
```

5. Create a [.gitignore file](https://git-scm.com/docs/gitignore) to ignore the *data* and *lightning_logs* folders.
6. Remove the notebook, and check that the training script is working correctly:

```bash
python train.py
```

7. Merge the experimental branch into the main one, and delete the experimental branch:

```bash
git checkout main
git merge experimental_branch
git branch -d experimental  branch
```

Congratulations! You have concluded the first move to a reproducible deep learning world. :nerd_face:

Move to the next exercise:

```bash
git checkout exercise2_hydra
```
