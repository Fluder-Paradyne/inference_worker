from text_generation import Client
import runpod

client = Client("http://127.0.0.1:8080")
print()


def handler(event):
    print(event, "event")
    text = client.generate("What is Deep Learning?", max_new_tokens=20).generated_text
    # do the things

    return text


runpod.serverless.start({
    "handler": handler
})
